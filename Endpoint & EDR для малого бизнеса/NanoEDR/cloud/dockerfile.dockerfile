FROM python:3.12-slim
WORKDIR /app
COPY cloud/requirements.txt .
RUN pip install -r requirements.txt
COPY cloud/api .
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]