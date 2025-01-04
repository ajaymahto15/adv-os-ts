from fastapi import FastAPI
from fastapi.responses import JSONResponse
app = FastAPI()
@app.get("/add/{num1}/{num2}")
def index(num1: int, num2: int):
 return JSONResponse({'Sum': num1 + num2})
if __name__ == "__main__":
 import uvicorn
 uvicorn.run(app, host="0.0.0.0", port=8001)