export STARSHIP_CONFIG="$BASH_BASE/starship.toml"

if [ -x "$(command -v starship)" ]; then
  eval "$(starship init bash)"
fi
