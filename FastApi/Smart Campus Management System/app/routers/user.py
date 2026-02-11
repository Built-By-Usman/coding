from fastapi import APIRouter,Depends
from sqlalchemy.orm import Session
from app.schemas.user import UserResponse,UserCreate
from app.models.user import UserModel
from app.db.database import get_db
from typing import List
from app.repositories.user import get,create


router=APIRouter(
    prefix='/user',
    tags=['user']
)

@router.get('/',response_model=List[UserResponse])
def get_all_user(db:Session=Depends(get_db)):
   return get(db)

@router.post('/',response_model=UserResponse)
def create_user(request:UserCreate,db:Session=Depends(get_db)):
   return create(request=request,db=db)

     