#!/usr/bin/env -S bash -l
set -exv

#exec prerun
node_arch=$(cat /sys/devices/cpu/caps/pmu_name)


USER_HOME=$(getent passwd $(whoami) | cut -d: -f6)
USER_DATA_DIR="${USER_HOME/\/user\///data/}"
mkdir -p "${USER_DATA_DIR}/.config/code-server/extensions"
code-server \
    --auth="password" \
    --bind-addr="0.0.0.0:${port}" \
    --disable-telemetry \
    --extensions-dir="${USER_DATA_DIR}/.config/code-server/extensions" \
    --user-data-dir="${USER_DATA_DIR}" \
    --log debug
