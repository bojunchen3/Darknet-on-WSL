# Darknet-on-WSL
Deploy YOLOv3 with Darknet on WSL and using CUDA to accelerate.

Run below commands in Windows 10/11 cmd.
```
wsl --update
```
```
wsl --install
```
```
git clone https://github.com/bojunchen3/Darknet-on-WSL.git
```
Change directory to Darknet-on-WSL and run
```
source ./setup.sh
```
If you want to run main.py to inference multiple images in one command,
change directory to darknet and run
```
python3 main.py
```
After downloading cudnn archive for Linux x86_64 (Tar) from Nvidia website and put it to the same directory of Darknet-on-WSL and darknet, you can back to Darknet-on-WSL file and run
```
source ./cudnn.sh
```
to install cudnn.
