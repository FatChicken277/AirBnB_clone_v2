#!/usr/bin/python3
"""This module contains functions that starts a Flask web application.
"""
from flask import Flask, render_template
from models import storage
from models.state import State
from models.amenity import Amenity
from models.place import Place
from models.user import User


app = Flask(__name__)


@app.route('/hbnb_filters', strict_slashes=False)
def hbnb_filters():
    """Display webpage
    """
    items = storage.all(State).values()
    items2 = storage.all(Amenity).values()
    items3 = storage.all(Place).values()
    items4 = storage.all(User).values()
    return render_template(
        '100-hbnb.html', states=items,
        amenities=items2, places=items3, users=items4)


@app.teardown_appcontext
def storage_close(self):
    """After each request you must remove the current SQLAlchemy Session.
    """
    storage.close()


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
