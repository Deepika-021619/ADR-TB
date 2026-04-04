from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from database import get_db_connection

router = APIRouter(prefix="/tb_regimen", tags=["TB Regimen"])

class DrugDetailsRequest(BaseModel):
    report_id: str
    regimen_id: int | None = None
    time_since_value: int | None = None
    time_since_unit: str | None = None
    is_fdc: str
    brand_name: str
    batch_number: str
    dose_description: str
    tablet_frequency: str | None = None
    oral_only: str
    injectable_details: str | None = None
    previous_regimen_taken: str
    previous_regimen_details: str | None = None
    duration_previous_regimen: int | None = None

@router.post("/drug_details")
def save_drug_details(data: DrugDetailsRequest):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        # Get regimen info (safe)
        regimen_name = "Custom regimen"
        regimen_type = "Other"
        if data.regimen_id:
            cursor.execute("SELECT regimen_name, regimen_type FROM tb_regimens WHERE regimen_id = %s", (data.regimen_id,))
            regimen = cursor.fetchone()
            if regimen:
                regimen_name, regimen_type = regimen

        # SAFE defaults for DB
        safe_time_since = data.time_since_value or 0
        safe_duration = data.duration_previous_regimen or 0
        safe_tablet_freq = data.tablet_frequency or None
        safe_prev_details = data.previous_regimen_details or None
        
        cursor.execute("""
            INSERT INTO drug_details (
                report_id, drug_regimen, regimen_id, time_since_value, time_since_unit,
                is_fdc, brand_name, batch_number, dose_description, tablet_frequency,
                oral_only, injectable_details, previous_regimen_taken, previous_regimen_details,
                duration_previous_regimen
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            data.report_id, regimen_name, data.regimen_id, safe_time_since,
            data.time_since_unit, data.is_fdc, data.brand_name, data.batch_number,
            data.dose_description, safe_tablet_freq, data.oral_only,
            data.injectable_details, data.previous_regimen_taken, safe_prev_details,
            safe_duration
        ))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        next_screen = "fld_questionnaire" if regimen_type == 'FLD' else "sld_questionnaire"
        return {
            "message": "Drug details saved successfully",
            "next_screen": next_screen,
            "regimen_type": regimen_type
        }
        
    except Exception as e:
        conn.rollback()
        cursor.close()
        conn.close()
        raise HTTPException(status_code=400, detail=f"Database error: {str(e)}")
