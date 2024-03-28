#!/usr/bin/python3
from invoke import task, run
from fabric import Connection
from datetime import datetime

@task
def do_pack(c):
    """ """
    current_date = datetime.now().strftime("%Y%m%d%H%M%S")
    archive_name = f"web_static_{current_date}.tgz"
    local("mkdir -p versions")
    test = (f"tar -czvf versions/{archive_name} web_static/")
    if test.succeeded:
        return f"versions/{archive_name}"
    
if __name__ == "__name__":
    do_pack()
