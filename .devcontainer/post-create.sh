#!/bin/bash

set -euo pipefail

echo "Setting up development environment..."

# Install system packages
apt-get update && apt-get install -y \
    htop \
    strace \
    ltrace \
    lsof \
    ncdu \
    tree \
    jq \
    ripgrep \
    zsh \
    sqlite3 \
    gdal-bin \
    libgdal-dev

# Install Python tools
pip install --upgrade pip
pip install \
    pandas \
    numpy \
    scipy \
    matplotlib \
    seaborn \
    jupyterlab \
    ipython \
    black \
    isort \
    flake8 \
    mypy \
    pylint

# Install CLI tools
curl -LsSf https://astral.sh/uv/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- --unattended

# Install Oh My Zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Configure zsh
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

echo "Development environment setup complete!"
