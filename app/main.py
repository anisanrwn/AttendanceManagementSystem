import subprocess
import threading
import os
import logging
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.sessions import SessionMiddleware
from fastapi.staticfiles import StaticFiles
from starlette.middleware.sessions import SessionMiddleware
from dotenv import load_dotenv

from app.routes import employee_routes, permissionlist_routes, user_routes, login_routes, locksystem_routes, attendance_routes, maps_routes, permission_routes, profile_routes, dashboard_routes, activity_routes, profileemployee_routes

load_dotenv()

logging.getLogger("uvicorn.access").setLevel(logging.WARNING)

def run_backup():
    script_path = os.path.join("backup", "backup.js")
    subprocess.call(["node", script_path])

def start_backup_service():
    thread = threading.Thread(target=run_backup)
    thread.daemon = True
    thread.start()


main_app = FastAPI()

@main_app.on_event("startup")
async def startup_event():
    start_backup_service()

# Add CORS middleware to allow requests from specific origins
main_app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://127.0.0.1:5500"],  # Specify allowed origins
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods
    allow_headers=["*"],  # Allow all headers
)

# Add session middleware with secret key for secure sessions
main_app.add_middleware(
    SessionMiddleware,
    secret_key=os.getenv("SESSION_SECRET_KEY")
)

main_app.mount("/html", StaticFiles(directory="html"), name="html")

# Include route handlers (routers) for various functionalities
main_app.include_router(employee_routes.router)
main_app.include_router(user_routes.router)
main_app.include_router(login_routes.router)
main_app.include_router(locksystem_routes.router)
main_app.include_router(attendance_routes.router)
main_app.include_router(maps_routes.router)
main_app.include_router(permission_routes.router)
main_app.include_router(profile_routes.router)
main_app.include_router(permissionlist_routes.router)
main_app.include_router(dashboard_routes.router)
main_app.include_router(activity_routes.router)
main_app.include_router(profileemployee_routes.router)
