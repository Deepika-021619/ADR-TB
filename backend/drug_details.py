from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from backend.database import get_db_connection

router = APIRouter(prefix="/tb_regimen", tags=["TB Regimen"])  # ✅ Matches Flutter

class DrugDetailsRequest(BaseModel):
    report_id: str
    regimen_id: int | None = None           # ✅ Allows null
    time_since_value: int | None = None     # ✅ Allows null  
    time_since_unit: str | None = None      # ✅ Allows empty
    is_fdc: str                             # ✅ Required
    brand_name: str                         # ✅ Required
    batch_number: str                       # ✅ Required  
    dose_description: str                   # ✅ Required
    tablet_frequency: str | None = None     # ✅ String, not int
    oral_only: str                          # ✅ Required
    injectable_details: str | None = None   # ✅ Allows null
    previous_regimen_taken: str             # ✅ Required
    previous_regimen_details: str | None = None
    duration_previous_regimen: int | None = None  # ✅ Allows null
    other_regimen: str | None = None

@router.get("/regimens")  
def get_regimens():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT regimen_id, regimen_name, regimen_type FROM tb_regimens")
    regimens = [{"regimen_id": row[0], "regimen_name": row[1], "regimen_type": row[2]} 
                for row in cursor.fetchall()]
    cursor.close()
    conn.close()
    return regimens

@router.post("/drug_details")  # ✅ Exact Flutter endpoint
def save_drug_details(data: DrugDetailsRequest):

    print("================================")
    print("regimen_id:", data.regimen_id)
    print("other_regimen:", data.other_regimen)
    print("================================")
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        # 1. Get regimen name and type
        cursor.execute("SELECT regimen_name, regimen_type FROM tb_regimens WHERE regimen_id = %s", 
                      (data.regimen_id,))
        regimen = cursor.fetchone()
        if not regimen:
            raise HTTPException(status_code=404, detail="Regimen not found")
        
        regimen_name, regimen_type = regimen
        print("Database regimen:", regimen_name)

        if data.other_regimen is not None and data.other_regimen.strip() != "":
             regimen_name = data.other_regimen.strip()
             print("Final regimen to save:", regimen_name)
        
        # 2. Insert ALL 15 fields into drug_details (with defaults)
        cursor.execute("""
            INSERT INTO drug_details (
                report_id, drug_regimen, regimen_id, time_since_value, time_since_unit, 
                is_fdc, brand_name, batch_number, dose_description, tablet_frequency, 
                oral_only, injectable_details, previous_regimen_taken, previous_regimen_details, 
                duration_previous_regimen
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            data.report_id, 
            regimen_name,                    # From tb_regimens
            data.regimen_id,
            data.time_since_value,                    # ✅ Flutter ONLY
            data.time_since_unit,                     # ✅ Flutter ONLY  
            data.is_fdc,
            data.brand_name,
            data.batch_number,
            data.dose_description,                    # ✅ Flutter ONLY - NO default
            data.tablet_frequency,
           
            'Yes',                           # oral_only
            None,                            # injectable_details
            'No',                            # previous_regimen_taken
            None,                            # previous_regimen_details
            0                                # duration_previous_regimen
        ))
        
        conn.commit()
        
        # 3. Decide next screen based on FLD/SLD
        next_screen = "fld_questionnaire" if regimen_type == 'FLD' else "sld_questionnaire"
        
        cursor.close()
        conn.close()
        
        return {
            "message": "Drug details saved successfully",
            "next_screen": next_screen,      # ✅ Flutter uses this!
            "regimen_type": regimen_type
        }
        
    except Exception as e:
        cursor.close()
        conn.close()
        raise HTTPException(status_code=400, detail=f"Database error: {str(e)}")
