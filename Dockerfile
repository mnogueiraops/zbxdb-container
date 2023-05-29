#Use alpine linux lightweight container
FROM python:3.9.2-alpine3.13

# Prepare for deploying zbxdb
RUN mkdir /zbxdb
COPY . /zbxdb
RUN ls /zbxdb
RUN cd /zbxdb && pwd

# Install pyenv dependencies (curl, bash, git, patch, gcc, zlib)
RUN apk add curl
RUN apk add bash
RUN apk add git
RUN apk add patch
RUN apk add gcc
RUN apk add clang
RUN apk add zlib
RUN apk add readline-dev
RUN apk add sqlite-dev
RUN apk add bzip2-dev
RUN apk add llvm
RUN apk add openssl-dev
RUN apk add ncurses-dev
RUN apk add libffi-dev
RUN apk add gcompat
RUN apk add glib

# Create environment variables.
ENV HOME /zbxdb
ENV PATH /zbxdb/.pyenv/bin:$PATH

# Start doing actual zbxdb work.
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

RUN eval "$(pyenv init -)" 
RUN eval "$(pyenv virtualenv-init -)"
RUN echo python --version
#RUN pyenv install 3.9.2
#RUN pyenv global 3.9.2
RUN pip install -r /zbxdb/requirements.txt
##RUN cp -rp /zbxdb/etc $HOME/ cp -p zbxdb/logging.json.example $HOME/etc/ -- TODO: Uncomment and edit if trick with editing $HOME to /zbxdb.