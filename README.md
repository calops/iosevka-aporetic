# calops/iosevka-aporetic

Custom Iosevka config from [protesilaos/aporetic](https://github.com/protesilaos/aporetic). Nix flake derived from
[viperML/iosevka](https://github.com/viperML/iosevka).

Grab the latest zip file from [releases](https://github.com/calops/iosevka-aporetic/releases) or build the fonts with
nix.

```
$ nix build github:calops/iosevka-aporetic#aporetic-sans -L
```
## Symbols

Nerd fonts are not patched into the font. It is kind of a hack, and all terminals/editors I use support font fallback.

Download symbols separately: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/NerdFontsSymbolsOnly

## Forking

It should be easy to fork this repo to use your [custom build plan](./private-build-plans.toml).
