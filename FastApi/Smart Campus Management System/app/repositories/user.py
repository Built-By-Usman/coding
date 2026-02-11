from app.models.user import UserModel
from app.schemas.user import UserCreate
from sqlalchemy.orm import Session
from fastapi import status,HTTPException
from sqlalchemy.exc import SQLAlchemyError


def get(db:Session):
    users=db.query(UserModel).all()
    if not users:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,detail="There is no user available in database")
    return users;  

def create(request:UserCreate,db:Session):
    existing_user=db.query(UserModel).filter(UserModel.email==request.email).first()
    if existing_user:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,detail="User with this email is already exist")
    
    user=UserModel(name=request.name,email=request.email,password=request.password,role=request.role)

    try:
        db.add(user)
        db.commit()
        db.refresh(user)
        return user
    except SQLAlchemyError as e:
        db.rollback()
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,detail="Database error")