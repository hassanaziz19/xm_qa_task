from flask import Flask, jsonify
import time
import sys
import random

app = Flask(__name__)

delay = True if len(sys.argv) > 2 and sys.argv[2] == 'Y' else False


@app.errorhandler(404)
def invalid_route(e):
    return jsonify({'errorCode': e.code,
                    'description': 'ID not in range 1-100'}), 404


@app.route('/')
def index():
    return jsonify(message='Serve is UP!')


@app.route('/people/<int(min=1, max=100):number>/', methods=['GET'])
def get_people(number):
    if delay:
        time.sleep(random.uniform(0, 5))
    return jsonify({'person1': 'John',
                    'person2': 'Nick'})


@app.route('/planets/<int(min=1, max=100):number>/', methods=['GET'])
def get_planets(number):
    if delay:
        time.sleep(random.uniform(0, 5))
    return jsonify({'planet1': 'Earth',
                    'planet2': 'Mars'})


@app.route('/starships/<int(min=1, max=100):number>/', methods=['GET'])
def get_starships(number):
    if delay:
        time.sleep(random.uniform(0, 5))
    return jsonify({'starship1': 'galactica',
                    'starship2': 'spaceX'})


if __name__ == '__main__':
    import logging

    logging.basicConfig(filename='result/api.log', level=logging.DEBUG)
    app.run(host='0.0.0.0', port=int(sys.argv[1]))
