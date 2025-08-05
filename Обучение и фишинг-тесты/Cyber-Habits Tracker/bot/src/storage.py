from sqlalchemy import create_engine, Column, String, Integer, Date
from sqlalchemy.orm import declarative_base, sessionmaker
import os

DB_URL = os.getenv("DATABASE_URL", "sqlite:///data/cht.db")
engine = create_engine(DB_URL)
Session = sessionmaker(bind=engine)
Base = declarative_base()

class Answer(Base):
    __tablename__ = "answers"
    id = Column(Integer, primary_key=True)
    user = Column(String)
    date = Column(Date)
    points = Column(Integer)

class Badge(Base):
    __tablename__ = "badges"
    user = Column(String, primary_key=True)
    score = Column(Integer, default=0)
    badges = Column(String, default="")

Base.metadata.create_all(engine)