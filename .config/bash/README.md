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

## Basic argument parsing

A simple example of a `bash` argument parser:

```bash
POSITIONAL_ARGUMENTS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --flag-1)
            # process flag 1
            flag_1=1
            shift
            ;;
        --flag-2|--flag-3)
            # process flag 2 or flag 3
            flag_2_or_3="$1"
            shift
            ;;
        --option-1)
            value="$2"
            # process the value
            shift 2
            ;;
        --option-2|--option-3)
            option_2_or_3="$1"
            value="$2"
            shift 2
            ;;
        --) # end of options
            shift
            break
            ;;
        -*)
            echo "error: unkown option: $1"
            exit 1
            ;;
        *)
            # process positional argument
            POSITIONAL_ARGUMENTS+=("$1")
            shift
            ;;
    esac
done
```
