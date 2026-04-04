from fastapi import APIRouter, HTTPException
from backend.database import get_db_connection

router = APIRouter(prefix="/reports", tags=["Reports"])


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

            a.ADR_experienced,

            s.system_name,
            s.symptom_name,
            s.symptom_present,
            s.severity

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

        LEFT JOIN adr_data a 
            ON r.report_id = a.report_id

        LEFT JOIN system_types s 
            ON r.report_id = s.report_id

        WHERE r.report_id = %s
    """

    cursor.execute(query, (report_id,))
    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    if not rows:
        raise HTTPException(status_code=404, detail="Report not found")

    # -----------------------------
    # Build structured JSON output
    # -----------------------------

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

        "adr_experienced": first["ADR_experienced"],

        "systems": {}
    }

    # Group symptoms by system
    for row in rows:
        if row["system_name"] is None:
            continue

        system = row["system_name"]

        if system not in report["systems"]:
            report["systems"][system] = []

        report["systems"][system].append({
            "symptom": row["symptom_name"],
            "present": row["symptom_present"],
            "severity": row["severity"]
        })

    return report
