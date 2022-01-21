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

## Notes

Rebasing to tip of another branch
- "replays" your commit(s) on top of latest of target branch

Rebase interactive and other
- AVOID rebase when you use `git pull` from the target branch
- rebase rewrites commit history, so reserve for feature and change branches
  (NOT trunk/main)
  - can be used to remove sensitive data that
    was checked in by accident
