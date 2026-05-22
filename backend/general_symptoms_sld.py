from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from backend.database import get_db_connection


router = APIRouter(
    tags=["General Symptoms SLD"]
)


# =====================================
# PYDANTIC MODEL
# =====================================

class GeneralSymptomsSLD(BaseModel):

    report_id: str

    # =====================================
    # Q34 FATIGUE
    # =====================================

    fatigue_present: Optional[str] = None

    fatigue_duration_weeks: Optional[int] = None

    fatigue_severity: Optional[str] = None

    fatigue_after_start: Optional[str] = None

    fatigue_before: Optional[str] = None

    fatigue_improved: Optional[str] = None

    fatigue_reappeared: Optional[str] = None

    fatigue_lifestyle: Optional[str] = None

    fatigue_other_issues: Optional[str] = None

    # =====================================
    # Q35 WEIGHT LOSS
    # =====================================

    weight_loss_present: Optional[str] = None

    weight_before: Optional[float] = None

    current_weight: Optional[float] = None

    # =====================================
    # Q36 FEVER
    # =====================================

    fever_present: Optional[str] = None

    fever_duration: Optional[str] = None

    fever_severity: Optional[str] = None

    fever_after_start: Optional[str] = None

    fever_before: Optional[str] = None

    fever_improved: Optional[str] = None

    fever_reappeared: Optional[str] = None

    # =====================================
    # Q37 JOINT PAIN
    # =====================================

    joint_pain_present: Optional[str] = None

    joint_pain_duration_weeks: Optional[int] = None

    joint_pain_severity: Optional[str] = None

    affected_joints: Optional[str] = None

    joint_other: Optional[str] = None

    joint_after_start: Optional[str] = None

    joint_before: Optional[str] = None

    joint_improved: Optional[str] = None

    joint_reappeared: Optional[str] = None

    # =====================================
    # Q38 HEADACHE
    # =====================================

    headache_present: Optional[str] = None

    headache_severity: Optional[str] = None

    headache_after_start: Optional[str] = None

    headache_before: Optional[str] = None

    headache_improved: Optional[str] = None

    headache_reappeared: Optional[str] = None

    # =====================================
    # Q39 ITCHING
    # =====================================

    itching_present: Optional[str] = None

    itching_severity: Optional[str] = None

    itching_after_start: Optional[str] = None

    itching_before: Optional[str] = None

    itching_improved: Optional[str] = None

    itching_reappeared: Optional[str] = None


# =====================================
# POST ENDPOINT
# =====================================

@router.post("/general-symptoms-sld")

def save_general_symptoms_sld(
    data: GeneralSymptomsSLD
):

    try:

        conn = get_db_connection()

        cursor = conn.cursor()

        query = """

        INSERT INTO general_symptoms_sld (

            report_id,

            fatigue_present,
            fatigue_duration_weeks,
            fatigue_severity,
            fatigue_after_start,
            fatigue_before,
            fatigue_improved,
            fatigue_reappeared,
            fatigue_lifestyle,
            fatigue_other_issues,

            weight_loss_present,
            weight_before,
            current_weight,

            fever_present,
            fever_duration,
            fever_severity,
            fever_after_start,
            fever_before,
            fever_improved,
            fever_reappeared,

            joint_pain_present,
            joint_pain_duration_weeks,
            joint_pain_severity,
            affected_joints,
            joint_other,
            joint_after_start,
            joint_before,
            joint_improved,
            joint_reappeared,

            headache_present,
            headache_severity,
            headache_after_start,
            headache_before,
            headache_improved,
            headache_reappeared,

            itching_present,
            itching_severity,
            itching_after_start,
            itching_before,
            itching_improved,
            itching_reappeared

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

            data.fatigue_present,
            data.fatigue_duration_weeks,
            data.fatigue_severity,
            data.fatigue_after_start,
            data.fatigue_before,
            data.fatigue_improved,
            data.fatigue_reappeared,
            data.fatigue_lifestyle,
            data.fatigue_other_issues,

            data.weight_loss_present,
            data.weight_before,
            data.current_weight,

            data.fever_present,
            data.fever_duration,
            data.fever_severity,
            data.fever_after_start,
            data.fever_before,
            data.fever_improved,
            data.fever_reappeared,

            data.joint_pain_present,
            data.joint_pain_duration_weeks,
            data.joint_pain_severity,
            data.affected_joints,
            data.joint_other,
            data.joint_after_start,
            data.joint_before,
            data.joint_improved,
            data.joint_reappeared,

            data.headache_present,
            data.headache_severity,
            data.headache_after_start,
            data.headache_before,
            data.headache_improved,
            data.headache_reappeared,

            data.itching_present,
            data.itching_severity,
            data.itching_after_start,
            data.itching_before,
            data.itching_improved,
            data.itching_reappeared
        )

        cursor.execute(
            query,
            values
        )

        conn.commit()

        cursor.close()

        conn.close()

        return {
            "message":
            "General symptoms SLD saved successfully"
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )