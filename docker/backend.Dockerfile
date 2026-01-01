FROM python:3.12-slim

WORKDIR /app

# system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
&& rm -rf /var/lib/apt/lists/*

# upgrade pip tooling
RUN pip install --upgrade pip setuptools wheel

# copy application source
COPY app/ /app

# install saleor (reads pyproject.toml directly)
RUN pip install .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
