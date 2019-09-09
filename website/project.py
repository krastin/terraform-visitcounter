from os import environ

from flask import Flask, escape, request
from flask_redis import Redis

app = Flask(__name__)
app.config['REDIS_HOST'] = environ.get("REDIS_HOST")
app.config['REDIS_PORT'] = 6379
app.config['REDIS_DB'] = 0
redis = Redis(app)

@app.route('/')
@app.route('/incr')
def incr():
    # HTTP GET params # name = request.args.get("name", "World")
    visits = int(redis.connection.incr("visits"))
    return 'Hello! Visits: %d' % visits

@app.route('/reset')
def reset():
    redis.connection.set("visits",0)
    visits = int(redis.connection.get("visits"))
    return 'Hello! Visits: %d' % visits