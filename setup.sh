# conda create -n autoformer python=3.6

# conda activate autoformer

# conda install -c anaconda numpy
# conda install -c anaconda pandas
# conda install -c anaconda scikit-learn

# conda install -c conda-forge matplotlib
# conda install pytorch==1.9.0 torchvision==0.10.0 torchaudio==0.9.0 -c pytorch


# HTS DEPENDENCIES
conda create --name autoformer python=3.7.2
conda activate autoformer

conda install -c anaconda numpy
conda install -c anaconda pandas
conda install -c conda-forge matplotlib

conda install -c anaconda scikit-learn

conda install pytorch==1.9.0 torchvision==0.10.0 cudatoolkit=10.2 -c pytorch -c conda-forge