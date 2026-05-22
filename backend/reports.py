

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from backend.database import get_db_connection
import uuid

router = APIRouter(prefix="/reports", tags=["Reports"])


# ---------------------------
# Create Report
# ---------------------------

class ReportCreateRequest(BaseModel):
    nik_id: str
    portal: str


@router.post("")
def create_report(data: ReportCreateRequest):

    report_id = "R" + uuid.uuid4().hex[:10]

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute(
            "INSERT INTO reports (report_id, nik_id, portal) VALUES (%s,%s,%s)",
            (report_id, data.nik_id, data.portal)
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        cursor.close()
        conn.close()

    return {
        "message": "Report created successfully",
        "report_id": report_id
    }


# ---------------------------
# Get Full Report
# ---------------------------

@router.get("/{report_id}")
def get_full_report(report_id: str):

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
         SELECT 
            r.report_id,
            r.portal,
            r.created_at,

            p.nik_id,
            p.p_id,
            p.p_name,
            p.gender,
            p.p_state,

            rd.r_name,
            rd.r_type,
            rd.hospital_address,
            rd.r_state,

            pe.age_years,
            pe.height_cm,
            pe.weight_kg,
            pe.tb_treatment_sd,
            tt.treatment_name,

            d.drug_regimen,
            d.time_since_value,
            d.time_since_unit,
            d.is_fdc,
            d.brand_name,
            d.batch_number,
            d.dose_description,
            d.tablet_frequency,
            d.oral_only,

            

            s.system_name,
            s.symptom_name,
            s.symptom_present,
            s.severity,
            s.duration_weeks,

            i.lft_done,
            i.ast_value,
            i.ast_uln,
            i.alt_value,
            i.alt_uln,
            i.alp_value,
            i.alp_uln,
            i.bilirubin_total,
            i.bilirubin_total_uln,

            i.hgb_done,
            i.hgb_value,
            i.hgb_lln,

            i.platelet_done,
            i.platelet_value,
            i.platelet_lln,

            i.uric_acid_done,
            i.uric_acid_value,
            i.uric_acid_uln
        FROM reports r

        JOIN patient_details p 
            ON r.nik_id = p.nik_id

        LEFT JOIN reporter_details rd 
            ON r.report_id = rd.report_id

        LEFT JOIN patient_event_details pe 
            ON r.report_id = pe.report_id

        LEFT JOIN treatment_types tt 
            ON pe.treatment_type_id = tt.treatment_type_id

        LEFT JOIN drug_details d 
            ON r.report_id = d.report_id

        

        LEFT JOIN system_types s 
            ON r.report_id = s.report_id
        LEFT JOIN investigations i 
        ON r.report_id = i.report_id

        WHERE r.report_id = %s
    """

    cursor.execute(query, (report_id,))
    rows = cursor.fetchall()

    # 🔹 Fetch general symptoms (CORRECTLY INDENTED)
    cursor.execute("""
        SELECT * FROM general_symptoms WHERE report_id = %s
    """, (report_id,))

    general_data = cursor.fetchone()

    cursor.close()
    conn.close()

    if not rows:
        raise HTTPException(status_code=404, detail="Report not found")

    first = rows[0]
    report = {
        "report_id": first["report_id"],
        "portal": first["portal"],
        "created_at": first["created_at"],

        "patient": {
            "nik_id": first["nik_id"],
            "p_id": first["p_id"],
            "name": first["p_name"],
            "gender": first["gender"],
            "state": first["p_state"]
        },

        "reporter": {
            "name": first["r_name"],
            "role": first["r_type"],
            "hospital_address": first["hospital_address"],
            "state": first["r_state"]
        },

        "treatment": {
            "treatment_name": first["treatment_name"],
            "age_years": first["age_years"],
            "height_cm": first["height_cm"],
            "weight_kg": first["weight_kg"],
            "tb_start_date": first["tb_treatment_sd"]
        },

        "drug_details": {
            "drug_regimen": first["drug_regimen"],
            "time_since_value": first["time_since_value"],
            "time_since_unit": first["time_since_unit"],
            "is_fdc": first["is_fdc"],
            "brand_name": first["brand_name"],
            "batch_number": first["batch_number"],
            "dose_description": first["dose_description"],
            "tablet_frequency": first["tablet_frequency"],
            "oral_only": first["oral_only"]
        },

        "systems": [],

        "general": general_data,

        "investigations": {

            "lft_done": first["lft_done"],
            "ast_value": first["ast_value"],
            "ast_uln": first["ast_uln"],
            "alt_value": first["alt_value"],
            "alt_uln": first["alt_uln"],
            "alp_value": first["alp_value"],
            "alp_uln": first["alp_uln"],
            "bilirubin_total": first["bilirubin_total"],
            "bilirubin_total_uln": first["bilirubin_total_uln"],

            "hgb_done": first["hgb_done"],
            "hgb_value": first["hgb_value"],
            "hgb_lln": first["hgb_lln"],

            "platelet_done": first["platelet_done"],
            "platelet_value": first["platelet_value"],
            "platelet_lln": first["platelet_lln"],

            "uric_acid_done": first["uric_acid_done"],
            "uric_acid_value": first["uric_acid_value"],
            "uric_acid_uln": first["uric_acid_uln"],
        }
    }

    # ==========================
    # ADD ALL SYSTEM ROWS
    # ==========================
    for row in rows:

        if row["system_name"] is None:
            continue

        report["systems"].append({

            "system_name": row["system_name"],

            "symptom_name": row["symptom_name"],

            "symptom_present": row["symptom_present"],

            "severity": row["severity"],

            "duration_weeks": row["duration_weeks"],
        })
    return report