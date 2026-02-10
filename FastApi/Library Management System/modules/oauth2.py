from fastapi import HTTPException,Depends,status
from typing import Annotated
from fastapi.security import OAuth2PasswordBearer
from .JWTtoken import verifyToken


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

async def get_current_user(token: Annotated[str, Depends(oauth2_scheme)]):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

    return verifyToken(credentials_exception,token)
    