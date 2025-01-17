#!/bin/bash

set -euo pipefail

# Check system resources
echo "Checking system resources..."
CPU_COUNT=$(nproc)
MEMORY_GB=$(free -g | awk '/^Mem:/{print $2}')
DISK_GB=$(df -BG / | awk 'NR==2{print $4}' | tr -d 'G')

echo "System resources:"
echo "- CPU cores: $CPU_COUNT"
echo "- Memory: ${MEMORY_GB}GB"
echo "- Disk space: ${DISK_GB}GB"

# Optimize installation based on available resources
if [ "$CPU_COUNT" -lt 4 ]; then
    echo "Detected limited CPU resources - optimizing installation..."
    export PIP_NO_CACHE_DIR=1
    export PIP_NO_BINARY=:all:
    export MAKEFLAGS="-j$CPU_COUNT"
fi

echo "Setting up development environment..."

# Install system packages
echo "Installing system packages..."
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
    libgdal-dev \
    parallel


# Install CLI tools
echo "Installing CLI tools..."
curl -LsSf https://astral.sh/uv/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- --unattended

# Install DuckDB
echo "Installing DuckDB..."
mkdir -p ~/.local/bin
curl -L https://github.com/duckdb/duckdb/releases/download/v1.1.3/duckdb_cli-linux-amd64.zip -o /tmp/duckdb.zip
unzip /tmp/duckdb.zip -d ~/.local/bin
chmod +x ~/.local/bin/duckdb
~/.local/bin/duckdb -c "INSTALL spatial;INSTALL httpfs;INSTALL json"

# Create DuckDB config
cat <<EOL > ~/.duckdbrc
.timer on
.width 180
LOAD json;
LOAD parquet;
LOAD spatial;
EOL

# Install Miller
echo "Installing Miller..."
curl -L https://github.com/johnkerl/miller/releases/download/v6.12.0/miller-6.12.0-linux-amd64.tar.gz -o /tmp/miller.tar.gz
tar -xzf /tmp/miller.tar.gz -C ~/.local/bin --strip-components=1
chmod +x ~/.local/bin/mlr

# Install fx
echo "Installing fx..."
curl -L https://github.com/antonmedv/fx/releases/download/35.0.0/fx_linux_amd64 -o ~/.local/bin/fx
chmod +x ~/.local/bin/fx

# Install llm plugins
echo "Installing llm plugins..."
pip install llm llm-groq llm-mistral

# Install Playwright
echo "Installing Playwright..."
pip install playwright
playwright install chromium

# Install Oh My Zsh plugins
echo "Configuring Zsh..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Configure zsh
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

# Create resource monitoring script
echo "Creating resource monitoring..."
cat <<EOL > /usr/local/bin/monitor-resources
#!/bin/bash
echo "CPU usage: \$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - \$1}')%"
echo "Memory usage: \$(free -m | awk '/^Mem:/{print \$3"/"\$2"MB"}')"
echo "Disk usage: \$(df -h / | awk 'NR==2{print \$3"/"\$2}')"
EOL
chmod +x /usr/local/bin/monitor-resources

echo "Development environment setup complete!"
echo "You can check system resources with: monitor-resources"
