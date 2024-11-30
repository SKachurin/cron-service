
FROM python:3.9-slim

WORKDIR /app

RUN pip install telethon==1.24.0 argparse colorama flask

COPY TgUserDetails.py .
COPY flask_service.py .

CMD ["python", "flask_service.py"]
