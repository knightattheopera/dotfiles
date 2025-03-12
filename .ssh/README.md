Mostly taken from Mulan's [excellent answer](https://stackoverflow.com/a/43009365) to [this SO question](https://stackoverflow.com/questions/3860112/multiple-github-accounts-on-the-same-computer).

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

