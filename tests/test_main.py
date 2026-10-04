import pytest
from fastapi.testclient import TestClient

from app.main import app, notes

client = TestClient(app)


@pytest.fixture(autouse=True)
def clear_notes():
    """Empty the notes list before every test so tests don't affect each other."""
    notes.clear()


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_list_notes_starts_empty():
    response = client.get("/notes")
    assert response.status_code == 200
    assert response.json() == []


def test_create_note():
    payload = {"title": "First note", "content": "Hello CI/CD"}
    response = client.post("/notes", json=payload)
    assert response.status_code == 200
    assert response.json() == payload


def test_created_note_appears_in_list():
    payload = {"title": "Second note", "content": "Testing is useful"}
    client.post("/notes", json=payload)
    response = client.get("/notes")
    assert response.json() == [payload]


def test_create_note_missing_field_fails():
    response = client.post("/notes", json={"title": "No content"})
    assert response.status_code == 422
