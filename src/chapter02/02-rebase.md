b17e0d10-7115-440d-b6f6-4bb70efe6e9c

# Git Rebase

For full details of git rebase, see the
[official documentation](https://git-scm.com/book/en/v2/Git-Branching-Rebasing).

**TL;DR**

Move your active branch to tip of trunk (ex. main)

```bash
git fetch
git rebase origin/main
```

Rewrite commit history (edit commit messages, squash, etc.)

```bash
git rebase -i <commit-id>
```
