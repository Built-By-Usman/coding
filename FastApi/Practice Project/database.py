from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base


DATABASEURL="postgresql://usman:ShaniMalik321@localhost:5432/practice_db"

engine=create_engine(DATABASEURL)

session_local=sessionmaker(autoflush=False,autocommit=False,bind=engine)

base=declarative_base()

def get_db():
    db=session_local()
    try:
        yield db
    finally:
        db.close()



