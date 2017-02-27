# Dumping out the users from an ldap directory

Sometimes it's nice to be able to fetch the LDAP users and their properties into an offline dict.

This does exactly that. It produces an output:

```
/data/users.pkl
```

that is a python pickle archive.

## Usage

Make sure that you expose the following environment variables before you run:

```
export LDAP_SERVER=server.mydomain.com
export LDAP_BASE_DN="dc=mydomain, dc=com"
export LDAP_USERNAME=username@mydomain.com
export LDAP_PASSWORD=password
```

Create the local docker image:
```
make image
```

Then you can issue:
```
make run
```

Which will dump out the ldap contents in a file, /tmp/data/users.pkl

