from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from database import get_db_connection

router = APIRouter(prefix="/patient_details", tags=["Patient details"])

class PatientCreateRequest(BaseModel):
    nik_id: str
    p_id: str | None = None
    p_name: str
    gender: str
    p_state: str

@router.post("/patients")
def create_patient(data: PatientCreateRequest):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # ✅ FIXED: Named columns + Correct order matching your schema
        # Schema: p_id, nik_id, p_name, gender, p_state (p_id allows NULL)
        cursor.execute("""
            INSERT INTO patient_details (p_id, nik_id, p_name, gender, p_state) 
            VALUES (%s, %s, %s, %s, %s)
        """, (data.p_id, data.nik_id, data.p_name, data.gender, data.p_state))
        
        conn.commit()
        return {"message": "Patient created successfully"}
        
    except Exception as e:
        conn.rollback()
        
        # ✅ Better duplicate detection
        if "Duplicate entry" in str(e) or "PRIMARY" in str(e) or "UNIQUE" in str(e):
            raise HTTPException(
                status_code=409, 
                detail=f"Patient with Nikshay ID '{data.nik_id}' already exists"
            )
        
        # ✅ Log other errors for debugging
        raise HTTPException(
            status_code=500, 
            detail=f"Database error: {str(e)}"
        )
    
    finally:
        # ✅ Proper cleanup
        cursor.close()
        conn.close()
