FROM python:3.10-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# OS dependencies (this step was failing earlier)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        poppler-utils \
        git \
        curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Python deps
COPY requirements.txt .
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

# App code


EXPOSE 8080
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8080"]
