from fastapi import FastAPI
from pydantic import BaseModel
import uuid

from database import get_db_connection

# ✅ CREATE THE APP (THIS WAS MISSING)
app = FastAPI(title="ADR Backend")

# --------------------
# Request model
# --------------------
class ReportStartRequest(BaseModel):
    patient_id: str
    portal: str  # Physician / Patient

from pydantic import BaseModel

class PatientCreateRequest(BaseModel):
    patient_id: str
    nikshay_id: str | None = None
    p_name: str
    gender: str
    p_state: str


# --------------------
# DB test endpoint
# --------------------
@app.get("/db-test")
def db_test():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SHOW TABLES;")
        tables = cursor.fetchall()
        cursor.close()
        conn.close()
        return {"tables": tables}
    except Exception as e:
        return {"error": str(e)}


# --------------------
# Start parient_details endpoint
# --------------------
@app.post("/patient_details/start")
def start_report(data: patient_detailsStartRequest):
    patient_id = "P-" + uuid.uuid4().hex[:10]

    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        INSERT INTO patient_details (Patient_id, nikshay_id, p_name, gender, p_state)
        VALUES (%s, %s, %s, %s, %s)
    """

    cursor.execute(query, (
        patient_id,
        data.patient_id,
        data.nikshay_id,
        data.p_name,
        data.gender,
        data.p_state
    ))

    conn.commit()
    cursor.close()
    conn.close()

    return {
        "message": "Patient_details created successfully",
        "patient_id": patient_id
    }
