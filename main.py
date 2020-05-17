import os
from app import app
from flask import request, redirect, jsonify
from werkzeug.utils import secure_filename
from scan import DocScanner
import json
import numpy as np
from flask_cors import cross_origin

ALLOWED_EXTENSIONS = set(["txt", "pdf", "png", "jpg", "jpeg", "gif"])

class NumpyEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.ndarray):
            return obj.tolist()
        return json.JSONEncoder.default(self, obj)

def allowed_file(filename):
    return "." in filename and filename.rsplit(".",1)[1].lower() in ALLOWED_EXTENSIONS

@app.route("/fileUpload", methods=["POST"])
@cross_origin()
def upload_file():
    # check if the post request has the file part
    if "file" not in request.files:
        resp = jsonify({"message":"No file part in the request"})
        resp.status_code = 400
        return resp
    file = request.files["file"]
    if file.filename == "":
	    resp = jsonify({"message" : "No file selected for uploading"})
	    resp.status_code = 400
	    return resp
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        image_path = os.path.join(app.config["UPLOAD_FOLDER"], filename)
        file.save(image_path)
        scanner = DocScanner()
        screenContour = scanner.image_bounding_box(image_path)
        screenContour = np.array(screenContour)
        resp = json.dumps({"message":"File successfully uploaded", "contour":screenContour, "image_path":image_path}, cls=NumpyEncoder)
        # resp.status_code = 201
        return resp
    else:
        resp = jsonify({"message": "Allowed file types are txt, pdf, png, jpg, jpeg"})
        resp.status_code = 400
        return resp

@app.route("/transformFile", methods=["POST"])
@cross_origin()
def transform_file():
    image_path = request.json["image_path"]
    screenContour = np.array(request.json["contour"])
    scanner = DocScanner()
    try:
        scanner.transform_after_contour(image_path, screenContour)
        resp = jsonify({"message":"File successfully uploaded", "image_path":image_path})
        resp.status_code = 201
    except:
        resp = jsonify({"message":"Transform failed to save", "image_path":image_path})
        resp.status_code = 400
    return resp

if __name__ == "__main__":
    app.run()