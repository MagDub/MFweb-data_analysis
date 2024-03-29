#!/bin/bash

#$ -N fit_mod9
#$ -e /data/mdubois/logs/
#$ -o /data/mdubois/logs/
#$ -t 598-657
#$ -S /bin/sh

# where to find basic custom functions
# where to find scripts for this job
model_path=/home/mdubois/scripts/modeling_web/webapp_data_analysis/8_fitmodel/holly

# Run Matlab
# matlab_command="addpath('$model_path');global jobId;jobId=$SGE_TASK_ID;"
matlab_command="addpath('$model_path');main_Holly_mod9($SGE_TASK_ID);"
/share/apps/matlab -nojvm -nodesktop -nosplash -nodisplay -singleCompThread -r $matlab_command
