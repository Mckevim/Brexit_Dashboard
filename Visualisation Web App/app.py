from flask import Flask
from flask import render_template
from pymongo import MongoClient
import json
from bson import json_util
from bson.json_util import dumps

app = Flask(__name__)

MONGODB_HOST = 'localhost'
MONGODB_PORT = 27017
DBS_NAME = 'Daily_Mail'
COLLECTION_NAME = 'Daily_Mail_Test'
FIELDS = {'date_time': True, 'head_line': True, 'author': True, 'sent_val': True, '_id': False}

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/data")
def data_extract():
    connection = MongoClient(MONGODB_HOST, MONGODB_PORT)
    collection = connection[DBS_NAME][COLLECTION_NAME]
    media_data = collection.find(projection=FIELDS)
    #jsonify the data
    json_list = []
    for news in media_data:
        json_list.append(news)
    json_list = json.dumps(json_list, default=json_util.default)
    connection.close()
    return json_list

if __name__ == "__main__":
    app.run(host='0.0.0.0',port=5000,debug=True)

