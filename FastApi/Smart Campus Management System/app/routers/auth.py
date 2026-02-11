from fastapi import APIRouter


router=APIRouter(
    prefix='/authentication',
    tags=['Authentication']
)

@router.post('/')
def create_user():
    return "hello"


