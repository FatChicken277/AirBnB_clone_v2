#!/usr/bin/python3
"""This module contains functions that starts a Flask web application.
"""
from flask import Flask, render_template
from models import storage
from models.state import State


app = Flask(__name__)


@app.route('/cities_by_states', strict_slashes=False)
def cities_by_states():
    """Routes /cities_by_states to display list of City objects
        linked to the State sorted by name (A->Z).
    """
    items = storage.all(State).values()
    return render_template('8-cities_by_states.html', states=items)


@app.teardown_appcontext
def storage_close(self):
    """After each request you must remove the current SQLAlchemy Session.
    """
    storage.close()


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
