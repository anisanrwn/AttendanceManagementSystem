import os
from fastapi import APIRouter
from fastapi.responses import JSONResponse
from dotenv import load_dotenv

load_dotenv()
router = APIRouter()

@router.get("/api/maps-key")
async def get_maps_key():
    return JSONResponse({"api_key": os.getenv("GOOGLE_MAPS_API_KEY")})
