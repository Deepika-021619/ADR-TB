from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from backend.database import get_db_connection

router = APIRouter(tags=["Other Side Effects"])


class OtherSideEffects(BaseModel):

    report_id: str

    injection_site_reaction: str | None = None
    severe_allergic_reaction: str | None = None
    anaphylaxis: str | None = None
    proteinuria: str | None = None
    sle: str | None = None
    dress_syndrome: str | None = None
    tremors: str | None = None
    gum_inflammation: str | None = None
    taste_change: str | None = None
    excess_salivation: str | None = None
    stomatitis: str | None = None
    pellagra: str | None = None
    increased_inr: str | None = None
    gynecomastia: str | None = None
    bloating: str | None = None
    loss_of_appetite: str | None = None
    memory_changes: str | None = None
    leg_swelling: str | None = None

    other_symptoms: str | None = None


@router.post("/save-other-side-effects")
def save_other_side_effects(
    data: OtherSideEffects
):

    try:

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        INSERT INTO other_side_effects (

            report_id,

            injection_site_reaction,
            severe_allergic_reaction,
            anaphylaxis,
            proteinuria,
            sle,
            dress_syndrome,
            tremors,
            gum_inflammation,
            taste_change,
            excess_salivation,
            stomatitis,
            pellagra,
            increased_inr,
            gynecomastia,
            bloating,
            loss_of_appetite,
            memory_changes,
            leg_swelling,

            other_symptoms

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

            %s
        )
        """

        values = (

            data.report_id,

            data.injection_site_reaction,
            data.severe_allergic_reaction,
            data.anaphylaxis,
            data.proteinuria,
            data.sle,
            data.dress_syndrome,
            data.tremors,
            data.gum_inflammation,
            data.taste_change,
            data.excess_salivation,
            data.stomatitis,
            data.pellagra,
            data.increased_inr,
            data.gynecomastia,
            data.bloating,
            data.loss_of_appetite,
            data.memory_changes,
            data.leg_swelling,

            data.other_symptoms
        )

        cursor.execute(query, values)

        conn.commit()

        cursor.close()
        conn.close()

        return {
            "message":
            "Other side effects saved successfully"
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )