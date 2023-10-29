export STARSHIP_CONFIG="$CONFIG_BASE/starship.toml"

if [ -x "$(command -v starship)" ]; then
  eval "$(starship init bash)"
fi
