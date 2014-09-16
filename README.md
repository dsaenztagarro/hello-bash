## Introduction

This project allows you to create shell commands to make easier your workflow\
development with `noisy_vagrant_boxes`. Commands created will let you run 
commands on guest machine from host shell in a less verbose way.

## Installation

Requirements: ruby 2.1.2

IMPORTANT: Create a config/proxies.yml file

Example:

```yaml
# config/proxies.yml
publication:
  'hello-usa':
    backend: usab
    backend_core: usabc
```

Run commands from root project folder:

```shell
bundle
rake
```

Enjoy! You can run now from noisy_vagrant_box folder commands for each module:

All commands will be executed prepending "rb" at the beginning. This will make
easier to identify all your generated commands in case you fall in troubles.

```
rbusab rake db:migrate
rbusabc ls -l
```

## Rake commands

- `vagrant:commands:delete`: Delete symlinks from user local bin folder
- `vagrant:commands:reset`: Delete and regenerate build folder
- `vagrant:commands:build`: Copy in build folder commands generated from config/proxies.yml
- `vagrant:commands:symlink`: Create symlinks from build commands to user local bin folder
- `default`: Run all previous commandS

### hiclone (removed temporaly)

Short way to clone git repo from "http://git.hola.com" to current directory

Example usage:

```shell
$ hiclone chef_noisy_frontend_cookbook
```

## Pending tasks

- [ ] Working version of bootstrap.sh equal to Rakefile.rb implementation
- [ ] Add hiclone and hiclonechef commands 
