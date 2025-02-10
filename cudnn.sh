cd
sudo tar -xvf cudnn*archive
cd ./cudnn*archive 
sudo cp -r ./lib/* /usr/lib/cuda/lib64/
sudo cp -r ./include/* /usr/include/
sudo chmod a+r /usr/include/cudnn*
sudo chmod a+r /usr/lib/cuda/lib64/libcudnn*
echo 'export PATH=/usr/include${PATH:+:${PATH}}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/lib/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
source ~/.bashrc
cd ../darknet
sed -i 's/CUDNN=0/CUDNN=1/' Makefile
make
./darknet detect cfg/yolov3.cfg yolov3.weights data/dog.jpg