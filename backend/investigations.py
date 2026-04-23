from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from backend.database import get_db_connection

router = APIRouter(tags=["Investigations"])

# ============================
# Pydantic Model
# ============================
class Investigation(BaseModel):
    report_id: str

    # LFT
    lft_done: str | None = None

    ast_value: float | None = None
    ast_uln: float | None = None
    ast_baseline: float | None = None

    alt_value: float | None = None
    alt_uln: float | None = None
    alt_baseline: float | None = None

    alp_value: float | None = None
    alp_uln: float | None = None
    alp_baseline: float | None = None

    bilirubin_total: float | None = None
    bilirubin_total_uln: float | None = None
    bilirubin_total_baseline: float | None = None

    bilirubin_direct: float | None = None
    bilirubin_direct_uln: float | None = None
    bilirubin_direct_baseline: float | None = None

    # Hemoglobin
    hgb_done: str | None = None
    hgb_value: float | None = None
    hgb_lln: float | None = None
    hgb_baseline: float | None = None

    # Platelets
    platelet_done: str | None = None
    platelet_value: float | None = None
    platelet_lln: float | None = None
    platelet_baseline: float | None = None

    # Uric Acid
    uric_acid_done: str | None = None
    uric_acid_value: float | None = None
    uric_acid_uln: float | None = None
    uric_acid_baseline: float | None = None


# ============================
# POST Endpoint
# ============================
@router.post("/investigations")
def save_investigations(data: Investigation):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        INSERT INTO investigations (
            report_id,

            lft_done,
            ast_value, ast_uln, ast_baseline,
            alt_value, alt_uln, alt_baseline,
            alp_value, alp_uln, alp_baseline,
            bilirubin_total, bilirubin_total_uln, bilirubin_total_baseline,
            bilirubin_direct, bilirubin_direct_uln, bilirubin_direct_baseline,

            hgb_done,
            hgb_value, hgb_lln, hgb_baseline,

            platelet_done,
            platelet_value, platelet_lln, platelet_baseline,

            uric_acid_done,
            uric_acid_value, uric_acid_uln, uric_acid_baseline
        )
        VALUES (
            %s,

            %s,
            %s, %s, %s,
            %s, %s, %s,
            %s, %s, %s,
            %s, %s, %s,
            %s, %s, %s,

            %s,
            %s, %s, %s,

            %s,
            %s, %s, %s,

            %s,
            %s, %s, %s
        )
        """

        values = (
            data.report_id,

            data.lft_done,
            data.ast_value, data.ast_uln, data.ast_baseline,
            data.alt_value, data.alt_uln, data.alt_baseline,
            data.alp_value, data.alp_uln, data.alp_baseline,
            data.bilirubin_total, data.bilirubin_total_uln, data.bilirubin_total_baseline,
            data.bilirubin_direct, data.bilirubin_direct_uln, data.bilirubin_direct_baseline,

            data.hgb_done,
            data.hgb_value, data.hgb_lln, data.hgb_baseline,

            data.platelet_done,
            data.platelet_value, data.platelet_lln, data.platelet_baseline,

            data.uric_acid_done,
            data.uric_acid_value, data.uric_acid_uln, data.uric_acid_baseline
        )

        cursor.execute(query, values)
        conn.commit()

        cursor.close()
        conn.close()

        return {"message": "Investigations saved successfully"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))