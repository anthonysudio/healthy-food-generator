from functools import wraps
from cs50 import SQL
from flask import Flask, flash, jsonify, redirect, render_template, request, session
from werkzeug.security import check_password_hash, generate_password_hash

app = Flask(__name__)
app.secret_key = "super_secret_key"

db = SQL("sqlite:///meals.db")


def login_required(f):
    """
    Decorate routes to require login.
    https://flask.palletsprojects.com/en/latest/patterns/viewdecorators/
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get("user_id") is None:
            return redirect("/login")
        return f(*args, **kwargs)
    return decorated_function


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""
    session.clear()

    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        if not username:
            flash("Must provide username")
            return render_template("login.html")
        elif not password:
            flash("Must provide password")
            return render_template("login.html")

        rows = db.execute("SELECT * FROM users WHERE username = ?", username)

        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], password):
            flash("Invalid username and/or password")
            return render_template("login.html")

        session["user_id"] = rows[0]["id"]
        flash("Logged in successfully!")
        return redirect("/")

    else:
        return render_template("login.html")

@app.route("/logout")
def logout():
    """Log user out"""
    session.clear()
    flash("Logged out successfully.")
    return redirect("/")


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        raw_username = request.form.get("username")
        password = request.form.get("password")
        confirmation = request.form.get("confirmation")

        if not raw_username or not password or not confirmation:
            flash("Must provide username, password, and confirmation")
            return render_template("register.html")

        username = raw_username.strip()
        if not username:
            flash("Username cannot be empty or blank spaces")
            return render_template("register.html")

        # 1. Check if passwords match
        if password != confirmation:
            flash("Passwords do not match.")
            return render_template("register.html", error="Passwords do not match.")

        # 2. Check if username already exists in meals.db
        existing_user = db.execute("SELECT * FROM users WHERE username = ?", username)
        if len(existing_user) > 0:
            flash("Username already exists.")
            return render_template("register.html", error="Username already exists.")

        # Hash password and insert user into database
        hash_pw = generate_password_hash(password, method="pbkdf2:sha256")
        db.execute("INSERT INTO users (username, hash) VALUES (?, ?)", username, hash_pw)

        flash("Registered successfully! Please log in.")
        return redirect("/login")

    return render_template("register.html")


@app.route("/favourite", methods=["POST"])
@login_required
def favourite():
    """Add a meal to user's favourites"""
    meal_id = request.form.get("meal_id")
    user_id = session["user_id"]

    if meal_id:
        db.execute(
            "INSERT OR IGNORE INTO favourites (user_id, meal_id) VALUES (?, ?)",
            user_id, meal_id
        )
        flash("Meal added to favourites!")
    
    return redirect("/favourites")


@app.route("/favourites")
@login_required
def favourites():
    """Display the user's favourite meals"""
    user_id = session["user_id"]

    meals = db.execute("""
        SELECT meals.* 
        FROM meals 
        JOIN favourites ON meals.id = favourites.meal_id 
        WHERE favourites.user_id = ?
        ORDER BY favourites.created_at DESC
    """, user_id)

    return render_template("favourites.html", meals=meals)


@app.route("/remove_favourite", methods=["POST"])
@login_required
def remove_favourite():
    """Remove a meal from favourites"""
    meal_id = request.form.get("meal_id")
    user_id = session["user_id"]

    if meal_id:
        db.execute(
            "DELETE FROM favourites WHERE user_id = ? AND meal_id = ?",
            user_id, meal_id
        )
        flash("Meal removed from favourites.")

    return redirect("/favourites")


@app.route("/")
def index():
    meals = db.execute("SELECT * FROM meals")
    return render_template("index.html", meals=meals)


@app.route('/suggest')
def suggest_meal():
    if request.args.get("success") == "true":
        flash("Thanks! Your suggestion was submitted for review.")
    return render_template('suggest.html')


@app.route('/generator')
def generator():
    countries_query = db.execute("SELECT DISTINCT country FROM meals WHERE country IS NOT NULL AND country != '' ORDER BY country ASC")
    countries = [row['country'] for row in countries_query]
    return render_template('generator.html', countries=countries)


@app.route("/health")
def health():
    return render_template("health.html")


@app.route('/api/random-meal')
def random_meal():
    country = request.args.get("country")
    if country and country != "All":
        meal_rows = db.execute("SELECT * FROM meals WHERE country = ? ORDER BY RANDOM() LIMIT 1", country)
    else:
        meal_rows = db.execute("SELECT * FROM meals ORDER BY RANDOM() LIMIT 1")

    if not meal_rows:
        return jsonify({"error": "No meals found"}), 404

    return jsonify({"meal": meal_rows[0]})


if __name__ == "__main__":
    app.run(debug=True)