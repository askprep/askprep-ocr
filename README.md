pip install virtualenv

python3 -m venv ../askprep-ocr

pip3 install -r requirements.txt 

source bin/activate

python3 main.py


Example Run
```
http://127.0.0.1:5000/fileUpload

input format
{
    file: FileObj,
    form: "max_width":500
}

output Format

{
    "message": "File successfully uploaded", "contour": [[320.0, 0.0], [320.0, 320.0], [0.0, 320.0], [0.0, 0.0]],
    "image_path": "./uploads/75424720_158322942228002_214430266637156352_n.png",
    "height":height,
    "width":width
}
```

```
http://127.0.0.1:5000/transformFile

input format
{
    "contour": [[320.0, 0.0], [320.0, 320.0], [0.0, 320.0], [0.0, 0.0]],
    "image_path": "./uploads/75424720_158322942228002_214430266637156352_n.png",
    "max_width":500
}

output Format
{
    "image_path": "./uploads/75424720_158322942228002_214430266637156352_n.png",
    "message": "File successfully uploaded",
    "height":height,
    "width":width
}
docker build -t askprep_ocr:1.0 .
docker run -it askprep_ocr:1.0