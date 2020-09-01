#!/usr/bin/python3
"""This module contains functions that starts a Flask web application.
"""
from flask import Flask


app = Flask(__name__)


@app.route('/', strict_slashes=False)
def hello_HBNB():
    """Routes / to display "Hello HBNB!"

    Returns:
        str: message.
    """
    return "Hello HBNB!"


@app.route('/hbnb', strict_slashes=False)
def HBNB():
    """Routes /hbnb to display "HBNB!"

    Returns:
        str: message.
    """
    return "HBNB!"


@app.route('/c/<text>', strict_slashes=False)
def c(text):
    """Routes /c/<text> to display display “C ” followed by the value
        of the text variable (replace underscore _ symbols with a space).

    Returns:
        str: message.
    """
    return "C {}".format(text.replace("_", " "))


@app.route('/python/', strict_slashes=False)
@app.route('/python/<text>', strict_slashes=False)
def python(text="is cool"):
    """Routes /python/(<text>) to display “Python ”, followed by the value
        of the text variable (replace underscore _ symbols with a space).

    Returns:
        str: message. (default="is cool")
    """
    text = text.replace("_", " ")
    return "Python {}".format(text)


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
