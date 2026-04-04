from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from backend.database import get_db_connection

router = APIRouter(prefix="/system_wise_symptoms", tags=["System Wise symptoms"])


# -------- Request model for system entry --------
class SystemsymptomsCreateRequest(BaseModel):
    option_id: int
    system_id: int
    option_text: str
    


@router.post("")
def create_system_entry(data: SystemsymptomsCreateRequest):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO system_wise_symptoms
        (option_id, system_id, option_text)
        VALUES (%s, %s, %s)
    """, (
        data.option_id,
        data.system_id,
        data.option_text
    ))

    conn.commit()
    system_id = cursor.lastrowid
    cursor.close()
    conn.close()

    return {
        "message": "Symptoms entry created",
        "system_id": system_id
    }
