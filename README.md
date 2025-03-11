# dotfiles

My personal configuration files.

Inspired by [mitxela](https://mitxela.com/projects/dotfiles_management).

Disclaimer: despite my best efforts, this repository is probably not suited for use.

## Managing vim plugins via git submodules

This repository uses submodules to manage vim plugins.
See this [guide on submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) if you want to get a better understanding of the subject.



## Cloning this repository

For the moment, this guide is pure speculation, as I haven't been able to test it.

Run the following commands, replacing `mydotfiles` by the name of your liking.

```bash
cd
mkdir mydotfiles
git --work-tree=$HOME --git-dir=$HOME/mydotfiles clone --bare --recurse-submodules https://github.com/knightattheopera/dotfiles.git mydotfiles
```

Things I'm sure about:
- The `--recurse-submodules` function is necessary to download the vim plugins that exist as submodules in this repository.
- The `--bare` option indicates that the directory `dotfiles` will be used as the git directory, and not as the work tree.
- The `--work-tree` option indicates that the working tree is the home directory.

Things I'm not sure about:
- Given that the `--bare` option is provided, is it necessary to give the `--git-dir` option as well?
- What happens to conflicts with existing files? Is it easier to handle them using ssh or https?

## Untracked files

This is a list of important configuration files that cannot be in this repository for security or privacy reasons.

- `~/.config/rclone/rclone.conf`
- `~/.config/bash/api-keys.sh`
- `~/.ssh/*/*.pem`
- `~/.ssh/config`
