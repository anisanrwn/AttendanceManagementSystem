from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.sessions import SessionMiddleware
from app.routes import employee_routes, user_routes, login_routes, locksystem_routes, attendance_routes

# Initialize FastAPI app
main_app = FastAPI()

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
    secret_key="9320f42d3712059ded88a848d7d44dced91d3667e5183efd",  # Your secret key here
)

# Include route handlers (routers) for various functionalities
main_app.include_router(employee_routes.router)
main_app.include_router(user_routes.router)
main_app.include_router(login_routes.router)
main_app.include_router(locksystem_routes.router)
main_app.include_router(attendance_routes.router)

