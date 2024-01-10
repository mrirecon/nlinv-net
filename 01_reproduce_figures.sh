#!/bin/bash
#Copyright 2023. TU Graz. Institute of Biomedical Imaging.
#Author: Moritz Blumenthal

./01_scripts/61_download_recodata.sh

./01_scripts/62_reco_rt_data_example1.sh
./01_scripts/63_reco_rt_data_example2.sh
./01_scripts/64_reco_t1_apex.sh
./01_scripts/65_reco_t1_mid.sh
./01_scripts/66_reco_t1_base.sh

./figure2/01_create_figure.sh
./figure3/01_create_figure.sh
./figure4/01_create_figure.sh
./figure5/01_create_figure.sh
./figure6/01_create_figure.sh
./figure7/01_create_figure.sh
./figure8/01_create_figure.sh

