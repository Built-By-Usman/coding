from sqlalchemy import Column,String,Integer,ForeignKey
from sqlalchemy.orm import relationship
from .database import Base


class UserModel(Base):
    __tablename__="users"
    id=Column(Integer,autoincrement=True,primary_key=True)
    name=Column(String)
    email=Column(String)
    password=Column(String)


    books=relationship("BookModel",back_populates="owner")

class BookModel(Base):
    __tablename__="books"
    id=Column(Integer,autoincrement=True,primary_key=True)
    name=Column(String)
    author=Column(String)
    yearOfPublication=Column(Integer)

    user_id=Column(Integer,ForeignKey("users.id"))
    owner=relationship("UserModel",back_populates="books")
    

