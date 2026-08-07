CREATE TABLE meals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    country, TEXT,
    description TEXT,
    ingredients TEXT,
    calories INTEGER,
    fat REAL,
    carbs REAL,
    sodium REAL,
    protein REAL
);