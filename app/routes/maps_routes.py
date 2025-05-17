import os
from fastapi import APIRouter, HTTPException
from fastapi.responses import JSONResponse
from dotenv import load_dotenv
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Load environment variables
load_dotenv()
router = APIRouter()

@router.get("/api/maps-key")
async def get_maps_key():
    api_key = os.getenv("MAPS_API_KEY")
    return JSONResponse({"api_key": api_key})
