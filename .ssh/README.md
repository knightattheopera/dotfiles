# Using .pem files

## Getting a key from a `.pem` file

To get the public key from a `.pem` file, run the following command:
	
```bash
ssh-keygen -y -f path/to/file.pem
```

## Generating a `.pem` key

To generate a `.pem` key, run the following command.

```bash
openssl genrsa -out path/to/file.pem 4096
```
Here, 4096 is the number of bits.

Alternatively, `ssh-keygen` can also be used, the difference being
that it will additionally generate a `.pem.pub` file that will contain the
public key. This file can be deleted, or used to copy the public key
without having to generate it from the `.pem` file.

```bash
ssh-keygen -m PEM -t rsa -b 4096 -f path/to/file.pem
```

# Directory structure and configuration file

Here's the suggested directory structure.

```
.ssh
├── README.md
├── config
├── github.com
│   └── knightattheopera.pem
├── gitlab.somedomain.com
│   └── someusername.pem
└── known_hosts
```

Here's what the `config` file should look like

```sshconfig
Host github.com-knightattheopera
	Hostname github.com
	User git
	IdentityFile ~/.ssh/github.com/knightattheopera.pem

Host gitlab.somedomain.com-someusername
	Hostname gitlab.somedomain.com
	User git
	IdentityFile ~/.ssh/gitlab.somedomain.com/someusername.pem
```

# References

The main reference is Mulan's [excellent answer](https://stackoverflow.com/a/43009365) to [this SO question](https://stackoverflow.com/questions/3860112/multiple-github-accounts-on-the-same-computer).

The website [ssh.com](https://ssh.com/academy/ssh) is a good
reference for all things related to ssh.
More specifically, documentation on the format of the config file can be found
[here](https://ssh.com/academy/ssh/config).
