from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from backend.database import get_db_connection

router = APIRouter(tags=["Investigations SLD"])


# ============================
# Pydantic Model
# ============================

class InvestigationSLD(BaseModel):

    report_id: str

    # =========================
    # HEMATOLOGICAL
    # =========================

    hgb_done: str | None = None
    hgb_value: float | None = None
    hgb_lln: float | None = None
    hgb_baseline: float | None = None

    platelet_done: str | None = None
    platelet_value: float | None = None
    platelet_lln: float | None = None
    platelet_baseline: float | None = None

    anc_done: str | None = None
    anc_value: float | None = None
    anc_lln: float | None = None
    anc_baseline: float | None = None

    neutropenic_fever: str | None = None

    # =========================
    # METABOLIC
    # =========================

    lactate_acidosis_done: str | None = None

    lactate_symptoms: str | None = None

    lactate_test_done: str | None = None

    serum_lactate: float | None = None
    serum_lactate_uln: float | None = None

    blood_ph: float | None = None
    blood_ph_uln: float | None = None

    bicarbonate: float | None = None
    bicarbonate_uln: float | None = None

    lactate_severity: str | None = None

    linezolid_related: str | None = None

    improved_after_stop: str | None = None

    recurred_after_restart: str | None = None

    # =========================
    # URIC ACID
    # =========================

    uric_acid_done: str | None = None

    uric_acid_value: float | None = None

    uric_acid_uln: float | None = None

    uric_acid_baseline: float | None = None

    # =========================
    # RENAL
    # =========================

    creatinine_done: str | None = None

    creatinine_value: float | None = None

    creatinine_uln: float | None = None

    creatinine_baseline: float | None = None


# ============================
# POST Endpoint
# ============================

@router.post("/investigations-sld")
def save_investigations_sld(
    data: InvestigationSLD
):

    try:

        conn = get_db_connection()

        cursor = conn.cursor()

        query = """
        INSERT INTO investigations_sld (

            report_id,

            hgb_done,
            hgb_value,
            hgb_lln,
            hgb_baseline,

            platelet_done,
            platelet_value,
            platelet_lln,
            platelet_baseline,

            anc_done,
            anc_value,
            anc_lln,
            anc_baseline,
            neutropenic_fever,

            lactate_acidosis_done,
            lactate_symptoms,
            lactate_test_done,

            serum_lactate,
            serum_lactate_uln,

            blood_ph,
            blood_ph_uln,

            bicarbonate,
            bicarbonate_uln,

            lactate_severity,

            linezolid_related,

            improved_after_stop,

            recurred_after_restart,

            uric_acid_done,
            uric_acid_value,
            uric_acid_uln,
            uric_acid_baseline,

            creatinine_done,
            creatinine_value,
            creatinine_uln,
            creatinine_baseline
        )

        VALUES (

            %s,

            %s,
            %s,
            %s,
            %s,

            %s,
            %s,
            %s,
            %s,

            %s,
            %s,
            %s,
            %s,
            %s,

            %s,
            %s,
            %s,

            %s,
            %s,

            %s,
            %s,

            %s,
            %s,

            %s,

            %s,

            %s,

            %s,

            %s,
            %s,
            %s,
            %s,

            %s,
            %s,
            %s,
            %s
        )
        """

        values = (

            data.report_id,

            data.hgb_done,
            data.hgb_value,
            data.hgb_lln,
            data.hgb_baseline,

            data.platelet_done,
            data.platelet_value,
            data.platelet_lln,
            data.platelet_baseline,

            data.anc_done,
            data.anc_value,
            data.anc_lln,
            data.anc_baseline,
            data.neutropenic_fever,

            data.lactate_acidosis_done,
            data.lactate_symptoms,
            data.lactate_test_done,

            data.serum_lactate,
            data.serum_lactate_uln,

            data.blood_ph,
            data.blood_ph_uln,

            data.bicarbonate,
            data.bicarbonate_uln,

            data.lactate_severity,

            data.linezolid_related,

            data.improved_after_stop,

            data.recurred_after_restart,

            data.uric_acid_done,
            data.uric_acid_value,
            data.uric_acid_uln,
            data.uric_acid_baseline,

            data.creatinine_done,
            data.creatinine_value,
            data.creatinine_uln,
            data.creatinine_baseline
        )

        cursor.execute(query, values)

        conn.commit()

        cursor.close()

        conn.close()

        return {
            "message":
            "SLD investigations saved successfully"
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )