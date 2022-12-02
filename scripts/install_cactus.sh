#Use conda and virtualenv to install the packages you need today 
#setup conda env
conda create -n cactus python=3.8
conda activate cactus
conda install virtualenv
# Users can also explicitly install in the cactus env
# conda install -n cactus virtualenv


#download cactus
workdir=/nas4/$USER/cactus
mkdir -p $workdir
cd $workdir
wget https://github.com/ComparativeGenomicsToolkit/cactus/releases/download/v2.3.0/cactus-bin-v2.3.0.tar.gz .
tar -xzf cactus-bin-v2.3.0.tar.gz
cd cactus-bin-v2.3.0

#set up virtual environment
virtualenv -p python3.8 cactus_env
echo "export PATH=$(pwd)/bin:\$PATH" >> cactus_env/bin/activate
echo "export PYTHONPATH=$(pwd)/lib:\$PYTHONPATH" >> cactus_env/bin/activate
source cactus_env/bin/activate
python3 -m pip install -U setuptools pip==21.3.1
python3 -m pip install -U -r ./toil-requirement.txt
python3 -m pip install -U .

