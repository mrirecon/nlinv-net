# NLINV-Net

This repository contains scripts to train and apply NLINV-Net on cardiac real-time data.
Reconstructions of the manuscript can be reproduced by running
```
$ ./01_reproduce_figures.sh
```
This script downloads the example data and pre-trained networks from Zenodo and runs the reconstructions and figure creation scripts.

[bart](https://github.com/mrirecon/bart) newer than commit a92a0357 and bc are required for the reconstructions.

To create the figures, the cfl2png tool of [view](https://github.com/mrirecon/view) is used for creation of pngs. [inkscape](https://inkscape.org/de/) is required for composing multiple pngs in the final figures. Moreover, python with minimal dependencies (matplotlib, numpy) is required for generating the figures for the subspace basis.

## Structure of Repository

* 00_data contains scripts to generate training dataset and the corresponding data lists.
  * Training datasets are created in this directory (or if set in the directory pointed to by the TRNDIR environment variable)
* 01_scripts contains most reusable scripts prefixed by
  * 0 for pre/post-processing
  * 1 for reconstruction
  * 2 for training
  * 4 for evaluation (multiple reconstructions)
* 1*_networks contains trained networks. The respective networks are configured by the conf.sh file containing configs as bash variables which are evaluated by the train scripts
* 2*_recos contains reconstructions (if not the RECODIR environment variable is set to point to another directory)

## Environment variables
This repository supports specifying different directories for data repositories.
It might be useful to store raw data and preprocessed training data outside this repository.
The following directories are set by default to the respective directories in this repository:
* RAWDIR=./00_data/10_raw_data/
* TRNDIR=./00_data/11_train_data/
* RECODIR=./


## Datasets on Zenodo

Pretrained network weights are available at Zenodo (DOI: [10.5281/zenodo.10493121](https://zenodo.org/records/10845041/files/)). 

Radial real-time data is available at Zenodo in the following datasets:
* Part 1: 10.5281/zenodo.10492333
* Part 2: 10.5281/zenodo.10912299
* Part 3: 10.5281/zenodo.10492343
* Part 4: 10.5281/zenodo.10492455
* Part 5: 10.5281/zenodo.10493095

Radial inversion recovery data is available at Zenodo in the following datasets:
* Part 1: 10.5281/zenodo.10491940
* Part 2: 10.5281/zenodo.10492124
* Part 3: 10.5281/zenodo.10492202
* Part 4: 10.5281/zenodo.10492221
* Part 5: 10.5281/zenodo.10492234
* Part 6: 10.5281/zenodo.10492254
* Part 7: 10.5281/zenodo.10492268
* Part 8: 10.5281/zenodo.10492275
* Part 9: 10.5281/zenodo.10492300

## Retrain Networks

For retraining the networks, all raw data can be downloaded with the scripts contained in *00_data/01_download_raw_data/*.
The directories *11_networks_rt/* and *12_networks_t1* contain network configurations in the respective *config.sh* file. To retrain a network, run
```
$ 01_scripts/21_train_network_rt.sh 11_networks_rt/<network>/

$ 01_scripts/23_train_network_t1.sh 12_networks_t1/<network>/
```
Multi-gpu support is implemented via openMPI which can be controlled with the *MPIRUN* variable in the respective config.
For training on HPC systems utilizing the Slurm workload manager, respective training scripts exist in the script directory. The configurations of the pre-trained networks contain the options to be trained on four GPUs.
