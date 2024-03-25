#!/usr/bin/python3
""" script to start a flask application """
from flask import Flask, render_template

app = Flask(__name__)


@app.route("/", strict_slashes=False)
def hello():
    """return function for this route"""
    return "Hello HBNB!"


@app.route("/hbnb", strict_slashes=False)
def hbnb():
    """return function for this route"""
    return "HBNB"


@app.route("/c/<text>", strict_slashes=False)
def c_is(text):
    """return function using variable URL"""
    ret = text.replace("_", " ")
    return f"C {ret}"


@app.route("/python/", defaults={'text': "is cool"}, strict_slashes=False)
@app.route("/python/<text>")
def python_is(text):
    """ return function using variable URL and defaults"""
    ret = text.replace("_", " ")
    return f"Python {ret}"


@app.route("/number/<int:n>", strict_slashes=False)
def number_is(n):
    """ return function using variable URL and defaults"""
    return f"{n} is a number"


@app.route("/number_template/<int:n>", strict_slashes=False)
def number_template(n):
    """returns a HTML template"""
    return render_template('5-number.html', n=n)



if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
