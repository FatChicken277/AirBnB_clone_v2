#!/usr/bin/python3
"""This module contains functions that starts a Flask web application.
"""
from flask import Flask, render_template
from models import storage
from models.state import State
from models.amenity import Amenity


app = Flask(__name__)


@app.route('/hbnb_filters', strict_slashes=False)
def hbnb_filters():
    """Display webpage
    """
    items = storage.all(State).values()
    items2 = storage.all(Amenity).values()
    return render_template(
        '10-hbnb_filters.html', states=items, amenities=items2)


@app.teardown_appcontext
def storage_close(self):
    """After each request you must remove the current SQLAlchemy Session.
    """
    storage.close()


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
