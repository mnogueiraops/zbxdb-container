#Use alpine linux lightweight container
FROM alpine:latest

# Install required dependencies
RUN apk update && \
    apk add --no-cache \
        git \
        build-base \
        zlib-dev \
        readline-dev \
        sqlite-dev \
        bzip2-dev \
        llvm \
        openssl-dev \
        ncurses-dev \
        libffi-dev \
        curl

# Set up the environment variables
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"

# Clone pyenv from GitHub
RUN git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"

# Set up pyenv initialization
RUN echo 'eval "$(pyenv init --path)"' >> /etc/profile.d/pyenv.sh
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> /etc/profile.d/pyenv.sh

# Install Python versions
ARG PYTHON_VERSIONS="3.9.2"
RUN for version in $PYTHON_VERSIONS; do \
        pyenv install $version; \
    done

# Set the global Python version
ARG GLOBAL_PYTHON_VERSION="3.9.2"
RUN pyenv global $GLOBAL_PYTHON_VERSION

# Install any additional Python packages or dependencies you may need
# For example:
# RUN pyenv exec pip install --upgrade pip

