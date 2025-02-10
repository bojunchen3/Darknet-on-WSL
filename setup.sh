cd
sudo apt update
sudo apt upgrade
sudo apt -y install nvidia-cuda-toolkit
sudo apt -y install make
git clone https://github.com/AlexeyAB/darknet
mv ./Darknet-on-WSL/main.py ./darknet/
mv ./Darknet-on-WSL/coco ./darknet/
cd darknet
ls -d ./coco/* >> list.txt
sed -i 's/GPU=0/GPU=1/' Makefile
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 1 --slave /usr/bin/g++ g++ /usr/bin/g++-12
make
wget https://pjreddie.com/media/files/yolov3.weights
./darknet detect cfg/yolov3.cfg yolov3.weights data/dog.jpg
