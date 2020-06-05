var tesseract = require('./node-tesseract');
var cv = require("opencv4nodejs");

var options = {
    l: "eng",
    psm: 1,
    // binary: "\"C:\\Program Files\\Tesseract-OCR\\tesseract.exe\"",
    config: "tsv"
};


function tsvToRawContent(tsv, ratio) {
    const lines = tsv.split("\n");

    let content = {
        "blocks": [],
        "entityMap": {}
    };
    let rectangles = [];
    const headers = lines[0].split("\t");
    let indexOfHeader = {};
    for (var j = 0; j < headers.length; j++) {
        indexOfHeader[headers[j]] = j;
    }

    for (let i = 1; i < lines.length; i++) {
        let currentline = lines[i].split("\t");
        if (currentline.length < headers.length) continue;
        const level = indexOfHeader['level'];
        if (currentline[level] === "2") { // Its a new block
            content["blocks"].push({
                "key": currentline[indexOfHeader["block_num"]],
                "text": "",
                "type": "unstyled",
                "depth": 0,
                "inlineStyleRanges": [],
                "entityRanges": [],
                "data": {}
            });
            rectangles.push({
                "type": "text",
                "left": parseFloat(currentline[indexOfHeader["left"]]) / ratio,
                "top": parseFloat(currentline[indexOfHeader["top"]]) / ratio,
                "width": parseFloat(currentline[indexOfHeader["width"]]) / ratio,
                "height": parseFloat(currentline[indexOfHeader["height"]]) / ratio
            });
            // const len = content["blocks"].length;
            // if( currentline[indexOfHeader["block_num"]] != "1")
            //     content["blocks"][len-1]["text"] = content["blocks"][len-1]["text"].concat("\n");
        } else if (currentline[level] === "3") { // If its a paragraph
            const len = content["blocks"].length;
            if (currentline[indexOfHeader["block_num"]] != "1" || currentline[indexOfHeader["par_num"]] != "1")
                content["blocks"][len - 1]["text"] = content["blocks"][len - 1]["text"].concat("\n");
        } else if (currentline[level] === "4") { // If it's a line
            // const len = content["blocks"].length;
            // content["blocks"][len-1]["text"] = content["blocks"][len-1]["text"].concat("\n");
        } else if (currentline[level] === "5") { // If it is word
            const len = content["blocks"].length;
            // if (currentline[indexOfHeader["word_num"]] == "1")
            //     content["blocks"][len - 1]["text"] = content["blocks"][len - 1]["text"].concat(currentline[indexOfHeader["text"]]);
            // else
            content["blocks"][len - 1]["text"] = content["blocks"][len - 1]["text"].concat(" ").concat(currentline[indexOfHeader["text"]]);
        }
    }

    return {
        "content": content,
        "rectangles": rectangles
    };
}

let imageToDraftContent = (filename, max_width) => {
    return new Promise(function (resolve, reject) {
        tesseract.process(filename, options, function (err, tsv) {
            if (err) {
                console.error(err);
                reject(err);
            } else {
                let image = cv.imread(filename);
                let ratio = 1;
                if (image.cols > max_width)
                   ratio = image.cols / max_width;
                const contentJson = tsvToRawContent(tsv, ratio);
                resolve(contentJson);
            }
        });
    });
}

module.exports.imageToDraftContent = imageToDraftContent;