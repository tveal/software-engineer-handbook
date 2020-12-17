05a2257b-3588-49e4-94ab-b77ef53d512a
# Git Submodules

> Use Case: manage a large set of repos as git submodules; ex. use `git grep`
across many repos

## Setup Submodules Repo

1. Setup new git repo

    ```bash
    mkdir all-the-things
    cd all-the-things
    git init
    echo "# all-the-things" > README.md
    git add README.md
    git commit -m 'initial commit'
    ```

2. Add submodules per repo you want to manage

    ```bash
    git submodule add <repo-url>
    ```

3. Commit the submodule registration changes

    ```bash
    git commit -m 'added submodules'
    ```


## Search Submodules

Two Options:
1. foreach (can run various commands per submodule)
2. git-grep command recursively

**Option 1**

```bash
git submodule foreach git grep <search-param>
```

**Option 2**

```bash
git grep --recurse-submodules <search-param>
```