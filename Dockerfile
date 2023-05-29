#Use alpine linux lightweight container
FROM python:3.9.2-alpine3.13

# Prepare for deploying zbxdb
RUN mkdir /zbxdb
COPY . /zbxdb
RUN ls /zbxdb
RUN cd /zbxdb && pwd

# Create environment variables.
ENV HOME /zbxdb
ENV PATH /zbxdb/.pyenv/bin:$PATH

# Start doing actual zbxdb work.
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

RUN eval "$(pyenv init -)" 
RUN eval "$(pyenv virtualenv-init -)"
RUN pyenv install 3.9.2
RUN pyenv global 3.9.2
RUN pip install -r /zbxdb/requirements.txt
##RUN cp -rp /zbxdb/etc $HOME/ cp -p zbxdb/logging.json.example $HOME/etc/ -- TODO: Uncomment and edit if trick with editing $HOME to /zbxdb.