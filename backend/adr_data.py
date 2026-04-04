from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from backend.database import get_db_connection


router = APIRouter(prefix="/adr_data", tags=["ADR Data"])

class adrCreateRequest(BaseModel):
    report_id: str
    ADR_experienced: bool

@router.post("/adr_data")
def create_adr_data(data: adrCreateRequest):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute(
        "INSERT INTO adr_data VALUES (%s,%s)",
        (data.report_id, data.ADR_experienced)
    )

    conn.commit()
    cursor.close()
    conn.close()

    return {"message": "ADR data created"}
