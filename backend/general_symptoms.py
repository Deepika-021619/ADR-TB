from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from backend.database import get_db_connection

router = APIRouter(tags=["General Symptoms"])


# =========================
# Pydantic Model
# =========================
class GeneralSymptoms(BaseModel):
    report_id: str

    # 24. Malaise
    malaise_present: Optional[str] = None
    malaise_duration_weeks: Optional[int] = None
    malaise_severity: Optional[str] = None
    malaise_onset: Optional[str] = None
    malaise_pre_existing: Optional[str] = None
    malaise_improved: Optional[str] = None
    malaise_recurred: Optional[str] = None

    # 25. Fever
    fever_present: Optional[str] = None
    fever_duration: Optional[str] = None
    fever_severity: Optional[str] = None
    fever_onset: Optional[str] = None
    fever_pre_existing: Optional[str] = None
    fever_improved: Optional[str] = None
    fever_recurred: Optional[str] = None

    # 26. Fatigue
    fatigue_present: Optional[str] = None
    fatigue_duration_weeks: Optional[int] = None
    fatigue_severity: Optional[str] = None
    fatigue_onset: Optional[str] = None
    fatigue_pre_existing: Optional[str] = None
    fatigue_improved: Optional[str] = None
    fatigue_recurred: Optional[str] = None
    fatigue_lifestyle: Optional[str] = None
    fatigue_other_issues: Optional[str] = None

    # 27 & 28
    discoloration_present: Optional[str] = None
    other_symptoms: Optional[str] = None


# =========================
# POST API
# =========================
@router.post("/general_symptoms")
def save_general_symptoms(data: GeneralSymptoms):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        INSERT INTO general_symptoms (
            report_id,

            malaise_present, malaise_duration_weeks, malaise_severity,
            malaise_onset, malaise_pre_existing, malaise_improved, malaise_recurred,

            fever_present, fever_duration, fever_severity,
            fever_onset, fever_pre_existing, fever_improved, fever_recurred,

            fatigue_present, fatigue_duration_weeks, fatigue_severity,
            fatigue_onset, fatigue_pre_existing, fatigue_improved, fatigue_recurred,
            fatigue_lifestyle, fatigue_other_issues,

            discoloration_present, other_symptoms
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s,
                %s, %s, %s, %s, %s, %s, %s,
                %s, %s, %s, %s, %s, %s, %s, %s, %s,
                %s, %s)
        """

        values = (
            data.report_id,

            data.malaise_present,
            data.malaise_duration_weeks,
            normalize_severity(data.malaise_severity),
            data.malaise_onset,
            data.malaise_pre_existing,
            data.malaise_improved,
            data.malaise_recurred,

            data.fever_present,
            data.fever_duration,
            normalize_severity(data.fever_severity),
            data.fever_onset,
            data.fever_pre_existing,
            data.fever_improved,
            data.fever_recurred,

            data.fatigue_present,
            data.fatigue_duration_weeks,
            normalize_severity(data.fatigue_severity),
            data.fatigue_onset,
            data.fatigue_pre_existing,
            data.fatigue_improved,
            data.fatigue_recurred,
            data.fatigue_lifestyle,
            data.fatigue_other_issues,

            data.discoloration_present,
            data.other_symptoms
        )

        cursor.execute(query, values)
        conn.commit()

        return {
            "message": "General symptoms saved successfully",
            "saved": True
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        cursor.close()
        conn.close()


# =========================
# Severity Normalization
# =========================
def normalize_severity(value: Optional[str]) -> Optional[str]:
    if value is None:
        return None

    val = value.lower()

    if "life" in val or "very high" in val or "high" in val:
        return "severe"
    if "severe" in val:
        return "severe"
    if "moderate" in val:
        return "moderate"
    if "mild" in val:
        return "mild"

    return "mild"