curl -X POST   http://127.0.0.1:5000/fileUpload -F 'file=@/mnt/c/Users/ayanb/Documents/sample_images/receipt.jpg' &
curl -X POST   http://127.0.0.1:5000/fileUpload -F 'file=@/mnt/c/Users/ayanb/Documents/sample_images/tax.jpeg' &
curl -X POST   http://127.0.0.1:5000/fileUpload -F 'file=@/mnt/c/Users/ayanb/Documents/sample_images/notepad.JPG' &
curl -X POST   http://127.0.0.1:5000/fileUpload -F 'file=@/mnt/c/Users/ayanb/Documents/sample_images/dollar_bill.JPG' &
curl -X POST   http://127.0.0.1:5000/fileUpload -F 'file=@/mnt/c/Users/ayanb/Documents/sample_images/chart.JPG' &
curl -X POST   http://127.0.0.1:5000/fileUpload -F 'file=@/mnt/c/Users/ayanb/Documents/sample_images/math_cheat_sheet.JPG' &
curl -X POST   http://127.0.0.1:5000/fileUpload -F 'file=@/mnt/c/Users/ayanb/Documents/sample_images/desk.JPG' &
curl -X POST   http://127.0.0.1:5000/fileUpload -F 'file=@/mnt/c/Users/ayanb/Documents/sample_images/cell_pic.jpg'
curl -X POST http://127.0.0.1:5000/transformFile -H 'Content-Type: application/json' -d '{"contour": [[293.76, 300.28799999999995], [2017.1519999999998, 267.64799999999997], [2206.464, 3179.136], [97.91999999999999, 3159.5519999999997]], "image_path": "./uploads/notepad.JPG"}' &
curl -X POST http://127.0.0.1:5000/transformFile -H 'Content-Type: application/json' -d '{"contour": [[2751.552, 753.984], [646.2719999999999, 851.904], [563.04, 1762.56], [2869.056, 1708.704]], "image_path": "./uploads/dollar_bill.JPG"}' &
curl -X POST http://127.0.0.1:5000/transformFile -H 'Content-Type: application/json' -d '{"contour": [[293.76, 195.84], [2947.392, 235.00799999999998], [3069.792, 2354.976], [171.35999999999999, 2369.6639999999998]], "image_path": "./uploads/chart.JPG"}' &
curl -X POST http://127.0.0.1:5000/transformFile -H 'Content-Type: application/json' -d '{"contour": [[15.552, 77.76], [1923.2640000000001, 93.312], [1923.2640000000001, 2576.448], [15.552, 2571.264]], "image_path": "./uploads/math_cheat_sheet.JPG"}' &
curl -X POST http://127.0.0.1:5000/transformFile -H 'Content-Type: application/json' -d '{"contour": [[19.584, 620.16], [1579.7759999999998, 378.62399999999997], [2389.248, 2128.1279999999997], [750.7199999999999, 2807.04]], "image_path": "./uploads/desk.JPG"}' &
curl -X POST http://127.0.0.1:5000/transformFile -H 'Content-Type: application/json' -d '{"contour": [[223.104, 1136.768], [2698.496, 1115.52], [2942.848, 4419.584], [31.872, 4472.704000000001]], "image_path": "./uploads/cell_pic.jpg"}' &
curl -X POST http://127.0.0.1:5000/transformFile -H 'Content-Type: application/json' -d '{"contour": [[489.59999999999997, 953.088], [1618.944, 887.808], [1867.0079999999998, 2558.9759999999997], [620.16, 2728.7039999999997]], "image_path": "./uploads/receipt.jpg"}' &
curl -X POST http://127.0.0.1:5000/transformFile -H 'Content-Type: application/json' -d '{"contour": [[1273.8, 0.0], [1273.8, 1650.0], [0.0, 1650.0], [0.0, 0.0]], "image_path": "./uploads/tax.jpeg"}' &