#!/usr/bin/python3
"""This module contains a function that generates a .tgz 
    archive from the contents of the web_static.
"""
from fabric.api import local
from datetime import datetime


def do_pack():
    """Fenerates a .tgz archive from the contents of the web_static.

    Returns:
        return the archive path if the archive has been correctly generated.
        Otherwise, it should return None.
    """
    t = datetime.now()
    formated = "{}{}{}{}{}".format(t.year, t.month, t.day, t.minute, t.second)
    file = "versions/web_static_{}.tgz".format(formated)

    local('mkdir -p versions')
    r = local('tar -czvf {} web_static/'.format(file))

    if r == 0:
        return file
    else:
        return None
