from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from backend.database import get_db_connection
import uuid #--used to generate universally unique IDs for treatment types

router = APIRouter(prefix="/treatment-types", tags=["Treatment Types"])


# -------- Request model --------
class TreatmentTypeCreate(BaseModel):
    treatment_name: str


# -------- Add a treatment type --------
@router.post("")
def add_treatment_type(data: TreatmentTypeCreate):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            INSERT INTO treatment_types (treatment_name)
            VALUES (%s)
            """,
            (data.treatment_name,)
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        cursor.close()
        conn.close()

    return {"message": "Treatment type added"}


# -------- Get active treatment types --------
@router.get("")
def get_treatment_types():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        """
        SELECT treatment_type_id, treatment_name
        FROM treatment_types
        WHERE is_active = TRUE
        """
    )
    result = cursor.fetchall()

    cursor.close()
    conn.close()

    return result
