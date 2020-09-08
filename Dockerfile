# Copyright (c) 2018 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.13-alpine as builder
COPY . /usr/src/network-resources-injector
WORKDIR /usr/src/network-resources-injector
RUN apk add --update --virtual build-dependencies build-base linux-headers bash && \
    make

FROM golang:1.13-alpine
COPY --from=builder /usr/src/network-resources-injector/bin/webhook /usr/bin/
COPY --from=builder /usr/src/network-resources-injector/bin/installer /usr/bin/

CMD ["webhook"]
