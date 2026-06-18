import requests

from app.core.config import (
    LM_STUDIO_URL,
    MODEL_NAME,
)

from app.utils.prompts import (
    build_study_prompt,
)


def ask_study_ai(
    topic: str,
    question: str,
) -> str:

    prompt = build_study_prompt(
        topic,
        question,
    )

    payload = {

        "model": MODEL_NAME,

        "messages": [
            {
                "role": "user",
                "content": prompt
            }
        ],

        "temperature": 0.4,

        "max_tokens": 300,

        "stream": False,
    }

    headers = {
        "Content-Type": "application/json"
    }

    try:

        response = requests.post(
            LM_STUDIO_URL,
            json=payload,
            headers=headers,
            timeout=300,
        )

        response.raise_for_status()

        result = response.json()

        if "choices" not in result:

            raise Exception(
                "Invalid AI response"
            )

        return result["choices"][0][
            "message"
        ]["content"]

    except Exception as e:

        raise Exception(str(e))