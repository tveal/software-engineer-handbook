b2a09cea-b1a5-48c3-a3fe-e1b50c724df3
# Babel JavaScript Compiler

**NOTE: Incomplete; Maybe you'll find this useful**

Install the Babel (plus linting) things as dev dependencies
```bash
npm i -D @babel/cli \
    @babel/core \
    @babel/plugin-proposal-class-properties \
    @babel/plugin-proposal-decorators \
    @babel/plugin-proposal-export-namespace-from \
    @babel/plugin-proposal-function-sent \
    @babel/plugin-proposal-json-strings \
    @babel/plugin-proposal-numeric-separator \
    @babel/plugin-proposal-throw-expressions \
    @babel/plugin-syntax-dynamic-import \
    @babel/plugin-syntax-import-meta \
    @babel/plugin-transform-runtime \
    @babel/preset-env \
    @babel/register \
    @babel/runtime \
    babel-eslint \
    babel-plugin-istanbul \
    eslint \
    eslint-config-airbnb-base \
    eslint-formatter-pretty \
    eslint-plugin-import \
    lint-staged
```

Add/update things in your package.json file
```json
{
    "main": "./lib/index.js",
    "files": [
      "lib"
    ],
    "scripts": {
        "build": "babel src --out-dir lib",
        "lint": "npm run lint:js",
        "lint:js": "eslint --fix --format=node_modules/eslint-formatter-pretty .",
        "lint:staged": "lint-staged"
    },
    "lint-staged": {
      "*.js": "eslint"
    },
    "pre-commit": "lint:staged"
}
```

Initialize eslint config
```
npx eslint --init
```

## Test Setup

```
npm i -D better-npm-run \
    chai \
    mocha \
    nyc \
    sinon \
    sinon-chai
```
