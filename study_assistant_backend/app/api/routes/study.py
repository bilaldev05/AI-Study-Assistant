from fastapi import (
    APIRouter,
    HTTPException,
)

from app.schemas.study import (
    StudyRequest,
    StudyResponse,
)

from app.services.llm_service import (
    ask_study_ai,
)

router = APIRouter()


@router.post(
    "/ask",
    response_model=StudyResponse,
)
def ask_question(
    data: StudyRequest,
):

    try:

        result = ask_study_ai(
            data.topic,
            data.question,
        )

        return StudyResponse(
            success=True,
            response=result,
        )

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e),
        )