import os
from fastapi import APIRouter
from fastapi.responses import JSONResponse
from dotenv import load_dotenv

load_dotenv()
router = APIRouter()

@router.get("/api/maps-key")
async def get_maps_key():
    api_key = os.getenv("MAPS_API_KEY")
    return JSONResponse({"api_key": api_key})
