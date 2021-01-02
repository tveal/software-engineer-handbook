66e1ac1c-0f66-4f8f-893d-5124087416be

# Provisioning Node.js

Given:
- Needs:
  - node
  - npm
- Git repo with update scripts (established from previous sections)

Then:
- Add new script to provision node and npm
  - additionally provision [pm2](https://pm2.keymetrics.io/) as we'll use it for
    serving the API/WebApp

## Create New File

In your pi-commander repo, add a new file in a new folder, _node_

```
bash/
  node/
    update.sh
```

If you want to create these from command-line:

```bash
mkdir bash/node
touch bash/node/update.sh
chmod +x bash/node/update.sh
```

## Approach

We'll use nvm (node version manager) to install node/npm very similar to the dev
setup doc for
[Install Node.js](../../book/5773411b-7fbd-4ecd-8d30-cd539841ee8b.md). There are
some caveats to doing this via a crontab update:
- nvm is setup with bash profile dependencies, which you don't
  get automatically when running via crontab
- manually loading the needed bash profile variables can short-circuit our
  scripts if using the `set -e` error handling

## Add Function to Utils

To solve the bash profile dependencies for nvm in scripts, add the following to
`bash/utils.sh`

```bash
function loadNvmIfInstalled() {
  set +e
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  set -e
}
# Make nvm accessible to scripts, if installed
loadNvmIfInstalled
```

Takeaways
- We define _and_ call the new function `loadNvmIfInstalled`; We'll need it for
  reuse, but also load nvm _when_ sourced into a script file
- Within the tight scope of this function, we restore error handling to bash
  default with `set +e`, then turn back to `set -e` (exit on failure)

## The Update Script

Add the following to `bash/node/update.sh`

```bash
#!/bin/bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/../utils.sh

function main() {
  if noVersion nvm; then
    echo "installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
    loadNvmIfInstalled
  fi

  if noVersion node; then
    echo "installing node..."
    nvm install --lts
  fi

  if noVersion pm2; then
    echo "installing pm2..."
    npm i -g pm2
  fi
}

function noVersion() {
  local version="$($1 -v 2> /dev/null)"
  echo "running noVersion on $1; version: '$version'"
  test -z "$version"
}

runMain "$@"
```

Takeaways
- nvm: if _not_ installed, `loadNvmIfInstalled` didn't do anything when sourcing
  `bash/utils.sh`
  - so we install nvm, then call `loadNvmIfInstalled` again
- we install `pm2` _globally_
- our `notInstalled` function defined earlier in `bash/utils.sh` is specific to
  Debian's package manager, so it doesn't work with node-based packages
  - so we define a custom `noVersion` function within the scope of node things

Now, if you run `bash/node/update.sh`, it should install nvm, node/npm, and pm2.
Run it _again_, and you should see output similar to this:

```log
2021-01-02 17:27:32 [START] update.sh {node}
running noVersion on nvm; version: '0.36.0'
running noVersion on node; version: 'v14.15.1'
running noVersion on pm2; version: '[PM2] Spawning PM2 daemon with pm2_home=/home/safari/.pm2
[PM2] PM2 Successfully daemonized
4.5.1'
2021-01-02 17:27:33 [COMPLETE] update.sh {node}
```

[Provisioning Node.js complete!](https://github.com/tveal/template-pi-commander/compare/v0.4-crontab...v0.5-node)
