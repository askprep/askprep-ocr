from flask import Flask
from flask_cors import CORS

UPLOAD_FOLDER = "./uploads"
app = Flask(__name__)
app.secret_key = "secret key"
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
app.config["MAX_CONTENT_LENGTH"] = 64*1024*1024
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'