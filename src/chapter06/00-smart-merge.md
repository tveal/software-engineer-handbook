5259d907-1870-41d0-8764-fca3eed75c7e

# Smart Merge of Objects

Use Case: reducing an array of objects and combining properties appropriately
per type
- number: add
- array: concatenate

**The Code**
```js
const { cloneDeep, isNumber, isArray, isPlainObject, mergeWith } = require('lodash');

const smartMerge = (a, b) => {
  const joiner = (src, dst) => {
    if (isNumber(dst) && isNumber(src)) return (src + dst);
    if (isArray(dst) && isArray(src)) return src.concat(dst);
    if (isPlainObject(dst) && isPlainObject(src)) return smartMerge(src, dst);
    return dst;
  };
  return mergeWith(cloneDeep(a), b, joiner);
};
```

**Example**

```js
const objectA = {
  production: {
    repositories: [
      'git@gitlab.com/tveal/example1.git',
    ],
    open: 1,
  },
  development: {
    repositories: [
      'git@gitlab.com/tveal/example1.git',
      'git@gitlab.com/tveal/example2.git',
      'git@gitlab.com/tveal/example3.git',
    ],
    open: 3,
  },
};

const objectB = {
  certification: {
    repositories: [
      'git@gitlab.com/tveal/example4.git',
    ],
    open: 0,
  },
  development: {
    repositories: [
      'git@gitlab.com/tveal/example5.git',
    ],
    open: 1,
  },
};

console.log([ objectA, objectB ].reduce(smartMerge, {}));
```

Output:

```bash
{
  production: { repositories: [ 'git@gitlab.com/tveal/example1.git' ], open: 1 },
  development: {
    repositories: [
      'git@gitlab.com/tveal/example1.git',
      'git@gitlab.com/tveal/example2.git',
      'git@gitlab.com/tveal/example3.git',
      'git@gitlab.com/tveal/example5.git'
    ],
    open: 4
  },
  certification: { repositories: [ 'git@gitlab.com/tveal/example4.git' ], open: 0 }
}
```
