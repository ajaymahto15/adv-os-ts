FROM python:3.10
ADD . /webapp/
RUN pip install --upgrade pip
RUN pip install fastapi uvicorn
EXPOSE 8001
CMD ["python", "webapp/main.py"]