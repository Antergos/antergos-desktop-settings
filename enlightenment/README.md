# Antergos setup for Enlightenment (e20)

Config can be found in "~/.e/e/config/standard/e.cfg"

## Using eet

1.1. List all keys, usually just "config"

`eet -l e.cfg`

1.2. Write human readable values to file e.src

`eet -d e.cfg config e.src`

1.3. Change setup

`nano e.src`

1.4. Compile human readable values to binary form and use compression

`eet -e e.cfg config e.src 1`
