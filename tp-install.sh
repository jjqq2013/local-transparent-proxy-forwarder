#!/bin/bash
set -e

git clone https://github.com/jjqq2013/pr0cks pr0cks
curl -o node-v9.3.0-linux-x64.tar.xz https://nodejs.org/dist/v9.3.0/node-v9.3.0-linux-x64.tar.xz && tar xJf node-v9.3.0-linux-x64.tar.xz
git clone https://github.com/jjqq2013/ForwardHttpToProxy
