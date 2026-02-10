from fastapi import FastAPI,Depends
from schemas import UserSchema
from sqlalchemy.orm import session
from database import base,engine,get_db
from models import User

app=FastAPI()

base.metadata.create_all(bind=engine)



@app.get('/')
def home():
    return {"detail":"Hello world"}

@app.post('/user',response_model=UserSchema)
def create_user(user:UserSchema,db:session=Depends(get_db)):
    user=User(name=user.name,age=user.age)
    db.add(user)
    db.commit()
    db.refresh(user)
    return user

@app.get('/get/{id}')
def user_with_id(user_id:int):
    return {"user_id":user_id}
