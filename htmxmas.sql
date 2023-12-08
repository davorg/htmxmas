DROP TABLE IF EXISTS present;
DROP TABLE IF EXISTS child;

CREATE TABLE child (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE present (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    notes TEXT,
    child_id INTEGER,
    bought BOOLEAN DEFAULT 0,
    FOREIGN KEY(child_id) REFERENCES child(id)
);
