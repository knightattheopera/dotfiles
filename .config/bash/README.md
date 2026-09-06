# `~/.bashrc` and `~/.profile`

## Bashisms

`~/.bashrc` is only every executed by `bash`, while
`~/.profile` is also meant to be executed by
strict POSIX shells. As such, so-called _bashisms_
must be avoided in `~/.profile`.
For example, on machine login, `~/.profile` is
executed by `/bin/sh`, which on Debian-based systems
points to `dash`,  a POSIX compliant shell which
doesn't recognize bashisms such as `source` or
arrays. To check for bashisms in `~/.profile`,
one can use the `checkbashisms` command (available
on Debian-based systems via the `devscripts` package), or
try to parse the file with `dash` directly:

```sh
checkbashisms ~/.profile
dash -n ~/.profile
```

## Which file should export environment variables?

Since `~/.profile` makes environment variables available
to a much wider range of programs than `~/.bashrc`, it stands
to reason that environment variables which should be
as discoverable as possible should be exported from `~/.profile`.
This includes language environments, and the XDG base directories.

On the other hand, `~/.bashrc` seems better suited for exporting variables
that are either specific to `bash`, or that should have limited visibility.
