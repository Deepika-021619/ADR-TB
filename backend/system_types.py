from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, validator
from backend.database import get_db_connection
from typing import Optional

router = APIRouter(prefix="/systems", tags=["System Symptoms"])

# Valid ENUM values from your schema
VALID_SYSTEMS = [
    'Gastrointestinal', 'SkinSubcutaneous', 'Centralnervous', 'Musculoskeletal', 
    'Peripheral nervous', 'Respiratory', 'Hematological', 'Cardiovascular', 
    'Ocular', 'Miscellaneous', 'Psychiatric', 'Genitourinary'
]
VALID_PRESENT = ['Yes', 'No']
VALID_SEVERITY = ['mild', 'moderate', 'severe', 'life-threatening']

class SystemCreateRequest(BaseModel):
    report_id: str
    system_name: str
    symptom_name: str
    symptom_present: str
    severity: str = "N/A"
    duration_weeks: int | None = None   # ✅ NEW
    
    
    @validator('system_name')
    def validate_system(cls, v):
        if v not in VALID_SYSTEMS:
            raise ValueError(f"Invalid system_name. Must be one of: {VALID_SYSTEMS}")
        return v
    
    @validator('symptom_present')
    def validate_present(cls, v):
        if v not in VALID_PRESENT:
            raise ValueError(f"Invalid symptom_present. Must be 'Yes' or 'No'")
        return v
    
    @validator('severity')
    def validate_severity(cls, v):
        if v not in VALID_SEVERITY:
            raise ValueError(f"Invalid severity. Must be one of: {VALID_SEVERITY}")
        return v

@router.post("")
def create_system_entry(data: SystemCreateRequest):
    """Save symptom ONLY if valid data"""
    print(f"📥 Received: {data}")  # Debug log
    
    # Quick check: Only save "Yes" symptoms (your rule)
    if data.symptom_present != 'Yes':
        print(f"⏭️ Skipping 'No' symptom: {data.symptom_name}")
        return {"message": "Skipped (only Yes symptoms saved)", "skipped": True}
    
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # INSERT with explicit columns
        cursor.execute("""
            INSERT INTO system_types 
            (report_id, system_name, symptom_name, symptom_present, severity, duration_weeks)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            data.report_id,
            data.system_name,
            data.symptom_name[:99],  # Truncate if too long
            data.symptom_present,
            data.severity,
            data.duration_weeks
        ))
        
        conn.commit()
        
        if cursor.rowcount > 0:
            print(f"✅ SAVED system_id: {cursor.lastrowid}")
            return {
                "message": "System entry created", 
                "system_id": cursor.lastrowid,
                "saved": True
            }
        else:
            raise HTTPException(status_code=400, detail="No rows inserted - invalid data")
            
    except HTTPException:
        raise
    except Exception as e:
        if conn:
            conn.rollback()
        print(f"❌ DB ERROR: {e}")
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

@router.get("/test/{report_id}")
def test_system(report_id: str):
    """Test endpoint - check existing data"""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM system_types WHERE report_id = %s", (report_id,))
    results = cursor.fetchall()
    cursor.close()
    conn.close()
    return {"report_id": report_id, "symptoms": results}
