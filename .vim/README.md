# Foreword
The purpose of this document is to document any experience
related to `vim` that I don't want to forget, mainly
because the mistakes I made were painful.

# Compiling vim from source

`vim-easycomplete` isn't working particularly well for me,
so I wanted to use `YouCompleteMe` instead, even if the latter
is much more than just a completion plugin.

At this moment, `YouCompleteMe` only works on versions
of `vim` younger than 9.1, but the latest version of `vim`
in the Ubuntu 22.04 repos is 8.2.

The solution is then to compile from source.

```bash
cd ~/development
git clone https://github.com/vim/vim.git vim
cd vim/src
```

Now, the next step is meant to ensure, among other things,
that `vim` is compiled with support for `python3` enabled.

```bash
./configure --with-features=huge --enable-python3interp=yes --prefix=/usr/share/local
```

At first glance everything seems to have gone well, but upon
inspecting the output, I realize the flags for python were
deemed "not sane", whatever that means, and the configuration
script decides to ignore my request for python support.

After much, much pain, the following options seem to work:

- `--with-features=huge`
- `--enable-python3interp=yes`
- `--with-python3-command=/usr/bin/python3.10`
- `--with-python3-config-dir=/usr/lib/python3.10/config-3.10-x86_64-linux-gnu`

You can run `ls /usr/lib/python3.10 | grep config` to find the exact directory.

- `--enable-multibyte`
- `--enable-cscope`
- `--prefix:/usr/share/local`

Unfortunately, I didn't manage to compile a version of `vim`
with clipboard support.

Note that, because of the way I had set up VanillaOS, I had to edit
the exported binary that `apx` puts in `~/.local/bin/vim` to run
`/usr/share/local/bin/vim` instead of `/usr/bin/vim`.

I tried to compile `vim` with `--prefix=/usr` but I had issues with
permissions which I wasn't able to solve.

## UltiSnips and `git`

I'm not sure why this issue appeared all of the sudden, but since
the default version of `vim` in the vanilla host (`/usr/bin/vim`) did
not have python3 support, UltiSnips complained when opening `vim` with
`git commit`. In the end, the solution I found was to edit
`~/.config/git/config` and to set `core.editor` to `~/.local/bin/vim`:

```gitconfig
[core]
    editor = ~/.local/bin/vim
```

This will probably cause some issues in the future.
