from fastapi import FastAPI

from fastapi.middleware.cors import (
    CORSMiddleware,
)

from app.api.routes.study import (
    router as study_router,
)

app = FastAPI(
    title="AI Study Assistant",
)


# CORS

app.add_middleware(
    CORSMiddleware,

    allow_origins=["*"],

    allow_credentials=True,

    allow_methods=["*"],

    allow_headers=["*"],
)


# ROUTES

app.include_router(
    study_router,

    prefix="/api/v1/study",

    tags=["Study Assistant"],
)


@app.get("/")
def root():

    return {
        "message":
        "AI Study Assistant Running"
    }

# python -m uvicorn app.main:app  --reload