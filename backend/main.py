from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import uuid

from database import get_db_connection
from patients import router as patient_router
from reports import router as reports_router
from treatment_types import router as treatment_router
from event import router as event_router
from reporter_details import router as reporter_router
from drug_details import router as drug_details_router
from adr_data import router as adr_router
from system_types import router as system_type_router
from tb_regimen import router as tb_regimen_router
from fastapi.middleware.cors import CORSMiddleware



app = FastAPI(title="ADR Backend", version="1.0.0")


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(patient_router)
app.include_router(reports_router)
app.include_router(event_router)
app.include_router(reporter_router)
app.include_router(treatment_router)
app.include_router(drug_details_router)
app.include_router(adr_router)
app.include_router(system_type_router)
app.include_router(tb_regimen_router)



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




    