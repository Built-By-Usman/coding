from fastapi import Depends,HTTPException,status
from fastapi import APIRouter
from typing import List
from ..schemas import BookSchema,showBookRM,showUserRM
from sqlalchemy.orm import Session
from ..database import getDb
from ..oauth2 import get_current_user
from ..repository.book import all,get,create,delete,update


router=APIRouter(
    prefix='/book',
    tags=['Books']
)


@router.get("/",response_model=List[showBookRM])
def getAllBooks(db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
    return all(db)
   


@router.get("/{id}",response_model=showBookRM,)
def getBookWithId(id:int,db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
   return get(id=id,db=db)


@router.post('/',response_model=showBookRM)
def addBook(request:BookSchema,db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
    return create(request=request,db=db)
        

    
    

@router.delete('/{id}')
def deleteBook(id:int,db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
    return delete(id=id,db=db)


@router.put('/{id}')
def updateBook(id:int,request:BookSchema,db:Session=Depends(getDb),current_user:showUserRM=Depends(get_current_user)):
    return update(id=id,request=request,db=db)

