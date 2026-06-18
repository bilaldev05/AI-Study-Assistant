from pydantic import BaseModel


class StudyRequest(BaseModel):
    topic: str
    question: str


class StudyResponse(BaseModel):
    success: bool
    response: str