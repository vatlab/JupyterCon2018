## This is a log of commands that I use to create a clean conda environment
## with SoS and a number of kernels on a MacBook Pro. It might or might not
## work for you.


## Note that with the new version of conda, conda should not be in $PATH so
## this script cannot be executed as a shell script. I do not know yet how
## to handle this case.

##
## New environment.
##
conda create --name JupyterCon18 python=3.6 -y
conda activate JupyterCon18


##
## javascript kernel
## 
## use node 8.9.3 because jupyterlab does not support nodejs 10.x
conda install nodejs=8.9.3 jupyter -y

mkdir -p $CONDA_PREFIX/etc/jupyter/nbdata $CONDA_PREFIX/etc/conda/activate.d $CONDA_PREFIX/etc/conda/deactivate.d

cat <<EOF > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh 
#!/bin/bash
export JUPYTER_DATA_DIR=$CONDA_PREFIX/etc/jupyter/nbdata
export JUPYTER_CONFIG_DIR=$CONDA_PREFIX/etc/jupyter/nbconfig
EOF

cat <<EOF > $CONDA_PREFIX/etc/conda/deactivate.d/env_vars.sh
#!/bin/bash 
unset JUPYTER_DATA_DIR
unset JUPYTER_CONFIG_DIR
EOF

conda deactivate
conda activate JupyterCon18

npm install -g ijavascript
ijsinstall


##
## R kernel
###

conda install -c r r-essentials r-feather -y
conda install -c conda-forge feather-format -y

##
## Sparql kernel 
##
pip install sparqlkernel
jupyter sparqlkernel install

##
## Bash kernel
##
pip install bash_kernel
python -m bash_kernel.install

##
## SoS notebook
conda install cython -y
conda install jupyter jupyterlab
pip install sos-notebook
python -m sos_notebook.install
jupyter labextension install jupyterlab-sos

##
## for presentation
pip install xlsx2csv
pip install bs4
