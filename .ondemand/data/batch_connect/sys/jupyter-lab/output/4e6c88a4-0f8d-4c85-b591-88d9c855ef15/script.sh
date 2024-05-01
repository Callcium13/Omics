#!/usr/bin/env -S bash -l
node_arch=$(cat /sys/devices/cpu/caps/pmu_name)
# Benchmark info
echo "TIMING - Starting main script at: $(date)"

# Set working directory to home directory
cd "${HOME}"
# disable crash logs by default
ulimit -S -c 0

#
# Start Jupyter Notebook Server
#

echo "TIMING - Starting jupyter at: $(date)"
set -x
USER_HOME=$(getent passwd $(whoami) | cut -d: -f6)
USER_DATA_DIR="${USER_HOME/\/user\///data/}"
/opt/jupyterhub/pyvenv/bin/jupyter-lab -y --no-browser --config="${CONFIG_FILE}" "$USER_DATA_DIR"
