5773411b-7fbd-4ecd-8d30-cd539841ee8b
# Install Node.js

[test link to other file](../../book/990aef78-054d-44cf-bee1-fe2bad77c363.md)

1. Install Node Version Manager:

    - https://github.com/nvm-sh/nvm or
      https://github.com/coreybutler/nvm-windows

2. Install Node:

    ```
    nvm install --lts
    ```
    
    If you want to install a specific node version:
    
    ```
    nvm install 12.4
    ```

## Configuration

**Node Versions**

If you have multiple node versions, and want to set the default:

```
nvm alias default 12.4
```

If you want to temporarily use a node version in the current session:
```
nvm use 8
```

**NPM**

You can set _global_ config for npm registries, but first, it's a good idea to
backup existing config, renaming the file:

```
mv ~/.npmrc ~/.npmrc-old
```

- Set a new main registry for all NPM packages, defaults to
  https://registry.npmjs.org/

    ```
    npm config set registry <registry-url>
    ```


- Scoped NPM package registries

    ```
    npm config set @myscope:registry <registry-url>
    ```
    **Replace** `<registry-url>` with valid npm registry url and `@myscope` with
    proper values
