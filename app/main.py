from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import employee_routes, user_routes, login_routes, locksystem_routes

main_app = FastAPI()

main_app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

main_app.include_router(employee_routes.router)
main_app.include_router(user_routes.router)
main_app.include_router(login_routes.router)
main_app.include_router(locksystem_routes.router)