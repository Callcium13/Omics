#!/usr/bin/env -S bash -l
node_arch=$(cat /sys/devices/cpu/caps/pmu_name)
# Benchmark info
echo "TIMING - Starting main script at: $(date)"

# Set working directory to home directory
cd "${HOME}"
# disable crash logs by default
ulimit -S -c 0

TOOLCHAIN=2021a
LOAD_SCIPY=no
LOAD_MATPLOTLIB=no

module use /apps/leuven/${VSC_OS_LOCAL}/${VSC_ARCH_LOCAL}${VSC_ARCH_SUFFIX}/${TOOLCHAIN}/modules/all

case "${TOOLCHAIN}" in
  2021a )
    module load JupyterLab/3.0.16-GCCcore-10.3.0
    [[ "${LOAD_SCIPY}" == 'yes' ]] && module load SciPy-bundle/2021.05-foss-2021a
    [[ "${LOAD_MATPLOTLIB}" == 'yes' ]] && module load matplotlib/3.4.2-foss-2021a ipympl/0.9.3-foss-2021a
    ;;
  2022a )
    module load JupyterLab/3.5.0-GCCcore-11.3.0
    [[ "${LOAD_SCIPY}" == 'yes' ]] && module load SciPy-bundle/2022.05-foss-2022a
    [[ "${LOAD_MATPLOTLIB}" == 'yes' ]] && module load matplotlib/3.5.2-foss-2022a ipympl/0.9.3-foss-2022a
    ;;
  2023a )
    module load JupyterLab/4.0.5-GCCcore-12.3.0
    [[ "${LOAD_SCIPY}" == 'yes' ]] && module load SciPy-bundle/2023.07-gfbf-2023a
    [[ "${LOAD_MATPLOTLIB}" == 'yes' ]] && module load matplotlib/3.7.2-gfbf-2023a ipympl/0.9.3-foss-2023a
    ;;
  * )
    echo "ERROR: Unsupported toolchain selected"
    exit 1
    ;;
esac
#
# Start Jupyter Notebook Server
#

echo "TIMING - Starting jupyter at: $(date)"
set -x
USER_HOME=$(getent passwd $(whoami) | cut -d: -f6)
USER_DATA_DIR="${USER_HOME/\/user\///data/}"
${EBROOTJUPYTERLAB}/bin/jupyter-lab -y --no-browser --config="${CONFIG_FILE}" "$USER_DATA_DIR"
