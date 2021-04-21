#!/usr/bin/python3
import subprocess
from os import environ
from flask import Flask

app = Flask(__name__)

fortune_size = "-s"
if "LONG_FORTUNE" in environ and len(environ["LONG_FORTUNE"]) !=0:
    # fortunes length will be > 160 characters
    fortune_size = "-l"

@app.route("/")
def fortune():
    result = subprocess.run(["/usr/games/fortune", fortune_size], stdout=subprocess.PIPE)
    return result.stdout

@app.route("/healthy")
def healthy():
    return "feeling quite healthy today\n"

if __name__ == "__main__":
    app.run(port=8080, host= '0.0.0.0')
