cd
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.2.2/local_installers/cuda-repo-wsl-ubuntu-12-2-local_12.2.2-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-12-2-local_12.2.2-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-12-2-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda
echo 'export PATH=/usr/local/cuda-12.2/include${PATH:+:${PATH}}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
source ~/.bashrc
sudo apt -y install nvidia-cuda-toolkit
sudo apt -y install make
git clone https://github.com/AlexeyAB/darknet
mv ./Darknet-on-WSL/main.py ./darknet/
mv ./Darknet-on-WSL/coco ./darknet/
cd darknet
ls ./coco >> list.txt
sed -i 's/GPU=0/GPU=1/' Makefile
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 1 --slave /usr/bin/g++ g++ /usr/bin/g++-12
make
wget https://pjreddie.com/media/files/yolov3.weights
./darknet detect cfg/yolov3.cfg yolov3.weights data/dog.jpg
