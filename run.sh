# Copyright 2019 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
CONTAINER_ID=$1
shift
PARAMS="$@"
# Default ports
GRPC_PORT=8554
ADB_PORT1=5554
ADB_PORT2=5555

# Check if custom ports are provided
if [ ! -z "$GRPC_PORT_CUSTOM" ]; then
  GRPC_PORT=$GRPC_PORT_CUSTOM
fi

if [ ! -z "$ADB_PORT1_CUSTOM" ]; then
  ADB_PORT1=$ADB_PORT1_CUSTOM
fi

if [ ! -z "$ADB_PORT2_CUSTOM" ]; then
  ADB_PORT2=$ADB_PORT2_CUSTOM
fi

docker run \
 --device /dev/kvm \
 --publish ${GRPC_PORT}:8554/tcp \
 --publish ${ADB_PORT1}:5554/tcp \
 --publish ${ADB_PORT2}:5555/tcp \
 -e TOKEN="$(cat ~/.emulator_console_auth_token)" \
 -e ADBKEY="$(cat ~/.android/adbkey)" \
 -e TURN \
 -e EMULATOR_PARAMS="${PARAMS}"  \
 ${CONTAINER_ID}
