# Install the base requirements for the app.
# This stage is to support development.
FROM python:3
WORKDIR /
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN mkdir uploads
RUN mkdir pyimagesearch
ADD app.py ./
ADD main.py ./
ADD scan.py ./
ADD pyimagesearch/imutils.py ./pyimagesearch/imutils.py
ADD pyimagesearch/transform.py ./pyimagesearch/transform.py

EXPOSE 5000
CMD [ "python", "./main.py" ]