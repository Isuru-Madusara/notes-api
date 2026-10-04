from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Notes API")

notes = []


class Note(BaseModel):
    title: str
    content: str


@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/notes")
def create_note(note: Note):
    notes.append(note)
    return note


@app.get("/notes")
def list_notes():
    return notes
