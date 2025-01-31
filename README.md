# Darknet-on-WSL
Deploy YOLOv3 with Darknet on WSL and using CUDA to accelerate.

Run below command in Windows10/11 cmd
```
wsl --update
```
```
wsl --install
```
```
git clone https://github.com/bojunchen3/Darknet-on-WSL.git
```
change directory to Darknet-on-WSL
```
source ./setup.sh
```
if you want to run main.py to inference multiple images in one command
change directory to darknet and run
```
python3 main.py
```
