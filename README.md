# quickpath.fish

Automatically substitute path abbreviations in fish interactive shell.
Implemented using pure fish.


```
Usage: quickpath [OPTIONS]

Options:
  -l, --list              List all quickpath mappings
  --set <key> <path>      Create or update a quickpath mapping
  --unset <key>           Remove a quickpath mapping

Examples:
  quickpath --set c \~/.config/
  quickpath --set d \~/Documents/
  quickpath --list
  quickpath --unset c
```

## Installation

Install with [fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install abhabongse/quickpath.fish  # assumes github.com by fisher command
```

Alternatively, you may copy respective files into `$FISH_CONFIG_DIR` directory
such as `~/.config/fish/` in the default cases.


## Usage Examples

```fish
# Set a quickpath substitution mapping for c/ into ~/.config/
quickpath --set c \~/.config/

# When a user types in the following (without needing to hit tab or return) ...
cd c/
# ... it immediately substitutes the prompt into the following
cd ~/.config/

# Add more quickpath mapping
# - Quickpath key may contain multiple characters
# - Subsituted path may contain spaces (do not forget to escape)
# - Path with spaces with be quoted when substituted
quickpath --set mv \~/Music/Music\ Videos/

# List all configured mappings
quickpath --list

# Remove some mappings
quickpath --unset df
```


## Configuration

Command `quickpath --set` affects only the running interactive session
and won’t persist across multiple sessions.
It is recommended to configure the list of the list of quickpaths
inside the file located at `$FISH_CONFIG_DIR/conf.d/quickpath.fish`.
Feel free to rename this configuration file as you see fit,
as fish shell scripts `$FISH_CONFIG_DIR/conf.d/` will be loaded by default.


## Help, Support, and Contribute

The project is maintained at [Codeberg][codeberg:repo]
and routinely mirror-pushed to [GitHub][github:repo].

If you are a user of this package, or if you have feedback or suggestions,
I would like to hear from you!

- [Create an issue on Codeberg][codeberg:issue]
- [Create a discussion on GitHub][github:discussion]
- Or send me a direct message


## Transparency Disclaimer

Chat-based Large Language Models are consulted while creating this plugin,
though I have vetted every single line of code before publishing this code.


## License

[Apache-2.0](./LICENSE) © Abhabongse Janthong


[codeberg:repo]: https://codeberg.org/abhabongse/quickpath.fish

[codeberg:issue]: https://codeberg.org/abhabongse/quickpath.fish/issues

[github:repo]: https://github.com/abhabongse/quickpath.fish

[github:discussion]: https://github.com/abhabongse/quickpath.fish/discussions
