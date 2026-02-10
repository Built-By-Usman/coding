from fastapi import FastAPI,Depends,status,HTTPException
from schemas import UserSchema
from sqlalchemy.orm import Session
from database import base,engine,get_db
from models import UserModel

app=FastAPI()

base.metadata.create_all(engine)



@app.get('/')
def home():
    return {"detail":"Hello world"}

@app.post('/user',response_model=UserSchema)
def create_user(user:UserSchema,db:Session=Depends(get_db)):
    user = UserModel(name=user.name,age=user.age)
    db.add(user)
    db.commit()
    db.refresh(user)
    return user

@app.get('/user/{user_id}')
def user_with_id(user_id:int,db:Session=Depends(get_db)):
    user=db.query(UserModel).where(user_id==UserModel.id).first()

    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,detail="User with this id is not exist")
    
    return user





