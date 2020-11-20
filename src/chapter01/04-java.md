990aef78-054d-44cf-bee1-fe2bad77c363
# Java

**Install**

The easiest way to install/manage Java on your Linux/Mac dev environment is to
use sdkman

1. [Install SDKMAN!](https://sdkman.io/install)
2. Find the java version identifier you want to install

    ```
    sdk list java
    ```

    install with the identifier you want
    ```
    sdk install java <identifier>
    ```

Notes on Java via sdkman:
- you might need to check for custom java env variables if you had java setup
  before

**Certificates**

If you interact with custom CA certificates, you might need to add these to your
java cacerts keystore. For sdkman, the current java cacerts are located at:

```
~/.sdkman/candidates/java/current/jre/lib/security/cacerts
```

Depending on your system setup, you might also need to check
`/etc/ssl/certs/java/cacerts`
