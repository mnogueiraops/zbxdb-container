#Use alpine linux lightweight container
FROM python:3.9.2-buster

# Prepare for deploying zbxdb
RUN mkdir /zbxdb
COPY . /zbxdb
RUN ls /zbxdb
RUN cd /zbxdb && pwd

# Install pyenv dependencies (curl, bash, git, patch, gcc, zlib)
RUN apt install curl
RUN apt install bash
RUN apt install git
RUN apt install patch
RUN apt install gcc
RUN apt install zlib1g-dev
#RUN apt install lib32readline-dev
RUN apt install sqlite
RUN apt install bzip2-dev
RUN apt install llvm
RUN apt install openssl-dev
RUN apt install ncurses-dev
RUN apt install libffi-dev
RUN apt install gcompat
RUN apt install glib

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