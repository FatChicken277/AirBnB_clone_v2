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


app.run(debug=True, host="0.0.0.0", port=5000)
