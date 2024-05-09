# ⚡️ quickshell ⚡️

Fast select day-to-day commands, because ⏰ is 💰!

<p align="center">
  <img src="./docs/quickshell.png">
</p>

## Getting started

Your frequent commands should be in `~/.quickshell`

```sh
# install
make install
# add your command
quickshell --add 
# run and have fun
quickshell
```

## Usage
```
⚡️ quickshell ⚡️

Fast select day-to-day commands, because ⏰ is 💰!

    --add, -a: Add a new command to the list.

    --remove, -r: Remove a command from the list.

    --list, -l: List all registered commands.

    --help, -h: Show this help message.
```

## Build for release

```sh
make build
```

## Uninstall

```sh
rm -f /usr/local/bin/quickshell ~/.quickshell
```
