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
    """Endpoint to securely provide the Google Maps API key to the frontend."""
    api_key = os.getenv("MAPS_API_KEY")  # Ganti dari MAPS_API_URL ke MAPS_API_KEY
    
    if api_key:
        logger.info("Google Maps API key found in environment variables")
    else:
        logger.warning("Google Maps API key NOT found in environment variables")
        return JSONResponse(
            status_code=500,
            content={"error": "Google Maps API key is not configured"}
        )
    
    return JSONResponse({"api_key": api_key})
