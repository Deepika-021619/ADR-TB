from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from backend.database import get_db_connection
import uuid

router = APIRouter(
    prefix="/reports",
    tags=["Patient Event Details"]
)


# -------- Request model --------
class PatientEventCreate(BaseModel):
    age_years: int
    height_cm: float | None = None
    weight_kg: float | None = None
    tb_treatment_sd: str   # YYYY-MM-DD
    treatment_type_id: int


# -------- Add patient event details --------
@router.post("/{report_id}/event")
def add_patient_event(report_id: str, data: PatientEventCreate):
    conn = get_db_connection()
    cursor = conn.cursor()

    # Check report exists
    cursor.execute(
        "SELECT 1 FROM reports WHERE report_id = %s",
        (report_id,)
    )
    if not cursor.fetchone():
        cursor.close()
        conn.close()
        raise HTTPException(status_code=404, detail="Report not found")

    try:
        cursor.execute(
            """
            INSERT INTO patient_event_details
            (report_id, age_years, height_cm, weight_kg, tb_treatment_sd, treatment_type_id)
            VALUES (%s, %s, %s, %s, %s, %s)
            """,
            (
                report_id,
                data.age_years,
                data.height_cm,
                data.weight_kg,
                data.tb_treatment_sd,
                data.treatment_type_id
            )
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        cursor.close()
        conn.close()

    return {
        "message": "Patient event details added",
        "report_id": report_id
    }
