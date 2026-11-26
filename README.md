# homebrew-signalbox

The [Homebrew](https://brew.sh) tap for [signalbox](https://github.com/alejandrovdev/signalbox):
one train per track for your Claude Code sessions.

## Install

```sh
brew install alejandrovdev/signalbox/signalbox
signalbox --version
```

Then set it up once and link a repository, as the
[quick start](https://github.com/alejandrovdev/signalbox#quick-start) shows.

## Upgrade

```sh
brew update
brew upgrade signalbox
```

## Uninstall

Remove the Claude Code hooks first: they run the installed command.

```sh
signalbox uninstall
brew uninstall signalbox
brew untap alejandrovdev/signalbox
```

## Issues

This repository holds only the formula. Report problems with signalbox in its
[issue tracker](https://github.com/alejandrovdev/signalbox/issues).
