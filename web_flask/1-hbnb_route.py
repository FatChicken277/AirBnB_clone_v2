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
    return "HBNB"


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
