var ocr = require('./node-ocr/ocr');
var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors');

//create express app
const app = express();
app.use(cors());

// parse request of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({extended:true}));
// parse requests of content-type - application/json
app.use(bodyParser.json());

// define a simple route
app.post('/ocr',(req,res)=>{
    let image_path = req.body["image_path"];
    ocr.imageToDraftContent(image_path).then(function(content){
        res.json(content);
    }).catch(err=>{
        console.error(err);
        res.status(500).send({"error":"Server Error"});
    });
});

app.listen(8080, ()=>{ 
	console.log("Server is listening on port 8080"); 
});