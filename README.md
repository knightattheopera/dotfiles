# dotfiles

My personal configuration files.

Inspired by [mitxela](https://mitxela.com/projects/dotfiles_management).

Disclaimer: this repository is for personal use.
The configuration files are most likely appropriate for any Debian-based Linux distribution,
but I have only tested them on my personal computer, so there are no guarantees.


## Cloning this repository

#### Command summary

```bash
cd ~
git clone --bare https://github.com/knightattheopera/dotfiles.git dotfiles
git --git-dir=dotfiles config --local showUntrackedFiles no
git --git-dir=dotfiles --work-tree=. reset --hard
git --git-dir=dotfiles --work-tree=. submodule update --init --recursive
```

#### Detailed version
To clone this directory, run the following commands.

First make sure you're in your home directory.
```bash
cd ~
```
Note: feel free to use any directory other than `~` if you just want to "download" the config files without it affecting your home directory.

Then, clone the repository into a directory of your choice.
I am using `dotfiles` but you can use any name you prefer.

```bash
git clone --bare https://github.com/knightattheopera/dotfiles.git dotfiles
```

This will create a *bare git repository*, that is, the files that are in `dotfiles` are the files you usually find in the `.git`
directory on most repositories.

In other words, the working tree (the set of files and folders you can edit or add to the repository or delete from the repository) is not
in `dotfiles`.
In fact, this cloned `git` repository doesn't have any working tree yet.

Indeed, notice that if you run `cd dotfiles` followed by `git status`, you will fail with the following error:
`fatal: this operation must be run in a work tree`.

So, up until now, `git` hasn't modified any files outside the `dotfiles` directory.

Before modifying anything, let's check the status of our working tree, which in this case is our home directory.

```bash
cd ~
# Don't show untracked files, otherwise git status will print every file the home directory file tree.
git --git-dir=dotfiles config --local showUntrackedFiles no
git --git-dir=dotfiles --work-tree=. status
```

You will now see the entire list of files in the remote repository marked as 'deleted'.

**WARNING**: Read the list carefully, because any file in that list that already exists in your computer will be overwritten by the next command.

In order to restore the deleted files, we simply ask `git` to revert any local changes to the repository.

```bash
git --git-dir=dotfiles --work-tree=. reset --hard
```

All that's left to do is download the `vim` plugins, which exist in this repository as submodules.
But, before doing so, we will simplify our life.

Indeed, at this, point all our config files should be in their correct places, so let us bring our `bash` configuration live.

```bash
exec bash
```

This should allow us to use the convenient `dotfiles` command, which is defined as an alias in `~/.config/bash/aliases.sh`,
and calls `git` with the appropriate `--git-dir` and `--work-tree` arguments.

**Note**: in case you did not use the name `dotfiles` for the directory where the repository lives, you will have to modifty the `--git-dir`
option in `~/.config/bash/aliases.sh` and then run `exec bash`.

Finally, we can initialize and update our submodules.

```bash
dotfiles submodule update --init --recursive
```

The `--recursive` flag ensures that any nested submodules are also cloned.

#### Note to self (or potential contributors)

After cloning the repository,
do not forget to edit `~/.dotfiles/config` and change the url of the remote to its ssh version.

## Managing `vim` plugins via git submodules

This repository uses submodules to manage `vim` plugins.
See this [guide on submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) if you want to get a better understanding of the subject.

To update all vim plugins, use the following command:

```bash
dotfiles submodule update --remote
```

To add a new vim plugin, use the following commands:

```bash
cd ~/.vim/pack/vendor/start/
dotfiles submodule add <some-plugin-url>
dotfiles commit -m "Add \`some-plugin\` as a submodule"
dotfiles push
```

---

# Additional Notes

## Zoom

To edit zoom configuration, you have to edit the `~/.config/zoomus.conf` file.
If zoom is installed through flatpak,
the file is located at `~/.var/app/us.zoom.Zoom/config/zoomus.conf`.

To disable the Mini Window in Zoom, you must edit this file and set the
`enableMiniWindow` option to `true`. Restart Zoom to apply the changes.
