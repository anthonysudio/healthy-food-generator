from cs50 import SQL
from flask import Flask, render_template

app = Flask(__name__)

db = SQL("sqlite:///meals.db")


@app.route("/")
def index():
    # Query all meals from the database
    meals = db.execute("SELECT * FROM meals")
    return render_template("index.html", meals=meals)