#!/bin/bash

#$ -N mod_7_t1_norm
#$ -j n
#$ -e /data/holly-host/mdubois/logs
#$ -o /data/holly-host/mdubois/logs
#$ -t 1-100
#$ -S /bin/sh

# where to find basic custom functions
# where to find scripts for this job
model_path=/home/mdubois/scripts/modeling_web/webapp_data_analysis/other/recovery/model/holly

# Run Matlab
# matlab_command="addpath('$model_path');global jobId;jobId=$SGE_TASK_ID;"
matlab_command="addpath('$model_path');HOLLY_main_mod7_t1_sim_normal($SGE_TASK_ID);"
/share/apps/matlab -nojvm -nodesktop -nosplash -nodisplay -singleCompThread -r $matlab_command
