from pydantic import BaseModel
from typing import List,Optional

class UserSchema(BaseModel):
    name:str
    email:str
    password:str



class BookSchema(BaseModel):
    name:str
    author:str
    yearOfPublication:int
    user_id:int



class showUserRM(BaseModel):
    name:str
    email:str
    books:List[BookSchema]

    model_config={
        "from_attributes":True
    }

class showBookRM(BaseModel):
    name:str
    author:str
    yearOfPublication:int
    owner:Optional[showUserRM]

    model_config={
        "from_attributes":True
    }


class LoginSchema(BaseModel):
    email:str
    password:str


class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    email: str | None = None

