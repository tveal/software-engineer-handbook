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
- You have a sequence of commits you want to combine into 1
- no git-pull (branch merge) commits between commits you want to squash
- (recommended) rebase your branch to tip of trunk
- familiarity with your default terminal text editor (ex. vim, nano)

For this example, suppose you have made 3 consecutive commits, with messages
1. WIP: sample commit 1
2. WIP: sample commit 2
3. WIP: sample commit 3

### Step 1: rebase command

We need to find the commit-id to use in the command, `git rebase -i <commit-id>`

Given we have made 3 commits to squash, we need to find the **4th** commit id.

Use `git log` to find the first commit _older_ than the commits you want to
squash. **NOTE: newest commits at top.**

```bash
dev@linux:/tmp/sample-repo$ git log

commit cf5714db245d93457f6aa0090e08daf869e72c5e (HEAD -> 8-git-squash-commits)
Author: dev <dev.example@email.com>
Date:   Tue Jan 25 08:54:11 2022 -0600

    WIP: sample commit 3

commit 97efdbce9215d0c0141c7ef3f91b91b8faa8b99a
Author: dev <dev.example@email.com>
Date:   Fri Jan 21 09:28:44 2022 -0600

    WIP: sample commit 2

commit ec4a3ecc42fcd0435b1aba342aa1e0ac8cecc7ae
Author: dev <dev.example@email.com>
Date:   Fri Jan 21 09:14:32 2022 -0600

    WIP: sample commit 1

commit 9883b7932f8b0af4a0654c3519ec3c3921e8d4ee (origin/main, origin/HEAD, origin/8-git-squash-commits, main)
Author: dev <dev.example@email.com>
Date:   Thu Jan 20 09:07:31 2022 -0600

    git: rebase notes
```

From this sample git-log, our commit-id for rebase is
`9883b7932f8b0af4a0654c3519ec3c3921e8d4ee`, hence our rebase command is:
```bash
git rebase -i 9883b7932f8b0af4a0654c3519ec3c3921e8d4ee
```

### Step 2: Squash Commits

Run the rebase command from step 1, which should open the git-rebase-todo in
your default terminal text editor (ex. nano or vim). **NOTE: newest commits at
bottom.**

```bash
  GNU nano 4.8        /tmp/sample-repo/.git/rebase-merge/git-rebase-todo
pick ec4a3ec WIP: sample commit 1
pick 97efdbc WIP: sample commit 2
pick cf5714d WIP: sample commit 3

# Rebase 9883b79..cf5714d onto 9883b79 (3 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified). Use -c <commit> to reword the commit message.
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```

When squashing commits, you roll newest up to the oldest. Hence,
in the git-rebase-todo, the last 2 commits listed will squash into the first.
Change the `pick` keyword for those last 2 commits to `s` or `squash`, then save
and exit the editor.

```bash
pick ec4a3ec WIP: sample commit 1
s 97efdbc WIP: sample commit 2
s cf5714d WIP: sample commit 3
```

Closing the todo editor should immediately take you into another editor for the
combined commit message. Edit to your liking, save and exit. If everything went well, you should see a message like

```
Successfully rebased and updated refs/heads/main.
```

You can inspect the result with `git log`; You should no longer see the original
3 WIP commits, but instead see a new one that is the combination of those
original 3 commits.

```bash
dev@linux:/tmp/sample-repo$ git log

commit 4199b0c82d3f02299a0a3bf78da50316eef497c0 (HEAD -> 8-git-squash-commits)
Author: dev <dev.example@email.com>
Date:   Tue Jan 25 09:07:59 2022 -0600

    WIP: sample commit 1
    
    WIP: sample commit 2
    
    WIP: sample commit 3

commit 9883b7932f8b0af4a0654c3519ec3c3921e8d4ee (origin/main, origin/HEAD, origin/8-git-squash-commits, main)
Author: dev <dev.example@email.com>
Date:   Thu Jan 20 09:07:31 2022 -0600

    git: rebase notes
```
