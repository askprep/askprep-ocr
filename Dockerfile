# Install the base requirements for the app.
# This stage is to support development.
FROM python:3
ENV http_proxy http://a.banerjee:AyanBanerjee1990@10.100.1.251:8080
ENV https_proxy http://a.banerjee:AyanBanerjee1990@10.100.1.251:8080
ENV ftp_proxy http://a.banerjee:AyanBanerjee1990@10.100.1.251:8080
WORKDIR /
RUN apt-get update
RUN apt-get install -y nodejs npm
RUN apt-get install -y tesseract-ocr
COPY requirements.txt .
COPY package.json .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN npm install
RUN apt-get install -y cmake build-essential
RUN npm install opencv4nodejs
RUN mkdir uploads
RUN mkdir pyimagesearch
RUN mkdir node-ocr
RUN mkdir node-ocr/lib
ADD app.py ./
ADD main.py ./
ADD scan.py ./
ADD pyimagesearch/imutils.py ./pyimagesearch/imutils.py
ADD pyimagesearch/transform.py ./pyimagesearch/transform.py
ADD app.js ./
ADD node-ocr/node-tesseract.js ./node-ocr/node-tesseract.js
ADD node-ocr/ocr.js ./node-ocr/ocr.js
ADD node-ocr/lib/tesseract.js ./node-ocr/lib/tesseract.js
ADD node-ocr/lib/utils.js ./node-ocr/lib/utils.js

EXPOSE 5000 8080
CMD python ./main.py & npm start