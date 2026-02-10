from sqlalchemy import Column,Integer,String
from database import base

class UserModel(base):
    __tablename__="users"

    id=Column(Integer,primary_key=True,index=True)
    name=Column(String,index=True)
    age=Column(Integer,index=True)
    
