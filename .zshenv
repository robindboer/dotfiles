export PATH="/home/robin/.ebcli-virtual-env/executables:$PATH"

# Rust cargo environment
. "$HOME/.cargo/env"

if [[ "$(uname)" == "Darwin" ]]; then
    export DOTNET_ROOT="/usr/local/share/dotnet"
else
    export DOTNET_ROOT="/usr/share/dotnet"
fi

export PATH=$PATH:$DOTNET_ROOT
