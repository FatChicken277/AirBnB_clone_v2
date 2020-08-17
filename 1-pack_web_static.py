#!/usr/bin/python3
from fabric.api import local
from datetime import datetime


def do_pack():
    t = datetime.now()
    formated = "{}{}{}{}{}".format(t.year, t.month, t.day, t.minute, t.second)
    file = "versions/web_static_{}.tgz".format(formated)

    local('mkdir -p versions')
    r = local('tar -czvf {} web_static/'.format(file))

    if r == 0:
        return file
    else:
        return None
