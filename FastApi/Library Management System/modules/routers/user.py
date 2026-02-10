from fastapi import Depends,HTTPException,status
from fastapi import APIRouter
from typing import List
from ..schemas import UserSchema,showUserRM
from sqlalchemy.orm import Session
from ..database import getDb
from ..repository.user import all,get,create,update,delete
from ..oauth2 import get_current_user


router=APIRouter(
    prefix='/user',
    tags=['Users']
)




@router.get("/",response_model=List[showUserRM])
def getAllUsers(db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
    return all(db=db)



@router.get("/{id}",response_model=showUserRM)
def getUserWithId(id:int,db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
    return get(id=id,db=db)


@router.post('/',response_model=showUserRM)
def addUser(request:UserSchema,db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
    return create(request=request,db=db)
    
    

@router.delete('/{id}')
def deleteUser(id:int,db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
    return delete(id=id,db=db)


@router.put('/{id}')
def updateUser(id:int,request:UserSchema,db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
 return update(id=id,request=request,db=db)
    

