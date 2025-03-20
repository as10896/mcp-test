# syntax=docker/dockerfile:1

FROM python:3.11-slim

WORKDIR /app

# To print directly to stdout instead of buffering output
ENV PYTHONUNBUFFERED=true

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy uv.lock* in case it doesn't exist in the repo
COPY pyproject.toml uv.lock* ./

RUN uv sync --frozen --no-cache

COPY . .

CMD ["uv", "run", "client.py", "./server.py"]
