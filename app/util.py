from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from main import AnimalName, DATABASE_URL


def load_animal_names():
    engine = create_engine(DATABASE_URL)
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    db = SessionLocal()

    # List of 15 animal names to add to the database
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
        "Cheetah",
        "Hippopotamus",
        "Rhino",
        "Panda",
        "Leopard",
        "Polar Bear",
    ]

    try:
        for name in animal_names:
            db_name = AnimalName(name=name)
            db.add(db_name)
        db.commit()
        print("Animal names added to the database!")
    except Exception as e:
        db.rollback()
        print(f"Error: {e}")
    finally:
        db.close()


if __name__ == "__main__":
    load_animal_names()
