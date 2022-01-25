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

## Squash Commits

Prerequisites
- no git-pull (branch merge) commits between commits you want to squash
- (recommended) rebase your branch to tip of trunk

1. Use `git log` to find the first commit _older_ than the commits you want to
   squash

    ```bash
    tveal@linux:~/repos/gitlab/software-engineer-handbook$ git log
    
    commit 9883b7932f8b0af4a0654c3519ec3c3921e8d4ee
    Author: tveal <safariscout@gmail.com>
    Date:   Fri Jan 21 09:28:44 2022 -0600

        git: rebase notes

    commit 97efdbce9215d0c0141c7ef3f91b91b8faa8b99a
    Author: tveal <safariscout@gmail.com>
    Date:   Fri Jan 21 09:14:32 2022 -0600

        git: add rebase page

    commit ec4a3ecc42fcd0435b1aba342aa1e0ac8cecc7ae
    Author: tveal <safariscout@gmail.com>
    Date:   Thu Jan 20 09:07:31 2022 -0600

        JS tricks: add smartMerge

    commit 79313cc0fa87e02aad21be397e7261d7cca07394 (HEAD -> 8-git-squash-commits, origin/main, origin/HEAD, origin/8-git-squash-commits, main)
    Author: tveal <safariscout@gmail.com>
    Date:   Mon May 10 22:19:49 2021 -0500

        js-tricks: comparing objects containing functions

    ```