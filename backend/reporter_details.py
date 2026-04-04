from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from database import get_db_connection



router = APIRouter(prefix="/Reporter_details", tags=["Reporter details"])

class ReporterCreateRequest(BaseModel):
    report_id: str
    r_name: str
    r_type: str
    hospital_address: str
    r_state: str
   
@router.post("/reporter_details")
def create_reporter_details(data: ReporterCreateRequest):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute(
        """
        INSERT INTO reporter_details
        (report_id, r_name, r_type, hospital_address, r_state)
        VALUES (%s, %s, %s, %s, %s)
        """,
        (
            data.report_id,
            data.r_name,
            data.r_type,
            data.hospital_address,
            data.r_state
        )
    )

    conn.commit()
    cursor.close()
    conn.close()

    return {"message": "Reporter details created"}

    


