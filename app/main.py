from fastapi import FastAPI, Request, Form, Depends
from fastapi.templating import Jinja2Templates
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
import random
import os

# Define your FastAPI app
app = FastAPI()
templates = Jinja2Templates(directory="templates")

# Database configuration
DATABASE_URL = os.environ.get("DATABASE_URL")
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# SQLAlchemy models
Base = declarative_base()


class AnimalName(Base):
    __tablename__ = "animal_names"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True)


Base.metadata.create_all(bind=engine)

# List of random animal names (initial data)
animal_names = [
    "Lion",
    "Tiger",
    "Elephant",
    "Giraffe",
    "Kangaroo",
    "Penguin",
    "Dolphin",
    "Koala",
    "Zebra",
]


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.get("/")
async def read_root(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


@app.post("/get_soul_animal/")
async def get_soul_animal(
    request: Request, name: str = Form(...), db: Session = Depends(get_db)
):
    # Retrieve a random animal name from the database
    soul_animal = get_random_animal_name(db)
    return templates.TemplateResponse(
        "index.html", {"request": request, "name": name, "soul_animal": soul_animal}
    )


@app.post("/load_animal_names/")
async def load_animal_names(request: Request, db: Session = Depends(get_db)):
    # Load animal names into the database
    load_animal_names_to_db(db)
    return templates.TemplateResponse(
        "index.html",
        {"request": request, "message": "Animal names loaded into the database!"},
    )


def load_animal_names_to_db(db: Session):
    for name in animal_names:
        db_name = AnimalName(name=name)
        db.add(db_name)
    db.commit()


def get_random_animal_name(db: Session):
    count = db.query(AnimalName).count()
    random_index = random.randint(0, count - 1)
    random_name = db.query(AnimalName).offset(random_index).first()
    return random_name.name
