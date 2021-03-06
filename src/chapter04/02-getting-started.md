961f3153-0cf6-4da1-a75b-ab3679170a33

# Getting Started

Given:
- Pi Hardware
  - Brains: [Raspberry Pi 4 (Model B)](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)
  - Storage: micro SD card (went with [Samsung Evo 128GB](https://www.samsung.com/us/computing/memory-storage/memory-cards/microsdxc-evo-select-memory-card-w--adapter-128gb--2017-model--mb-me128ga-am/))
  - Display: [Raspberry Pi 7" Touchscreen Display](https://www.raspberrypi.org/products/raspberry-pi-touch-display/)
  - Case: [Smarti Pi Touch 2](https://smarticase.com/products/smartipi-touch-2)
  - Power:
    - [CanaKit USB-C Power Supply](https://www.canakit.com/raspberry-pi-4-power-supply.html)
    - (optional) [CanaKit Power Switch](https://www.canakit.com/raspberry-pi-4-on-off-power-switch.html)
- Software
  - Access to a git repository server (such as GitHub, GitLab, etc.)
  - [Raspberry Pi OS](https://www.raspberrypi.org/software/)
  - Software dev environment
    - git
    - bash
    - node
    - code editor of your choice
  - (optional) Virtualization Software for Pi VM of
    [Pi Desktop](https://www.raspberrypi.org/software/raspberry-pi-desktop/)

Then:
- Let's dive straight into the code that will provision and update the Pi

## Name of Things

Naming things is hard. Especially in a tutorial. For simplicity, here's the
names I'll roll with. You're free to rename as desired, just substitute
appropriately as you read this.
- **repo name**: pi-commander
- **initial folder layout**:
    ```
    pi-commander/
      bash/
        wallpaper/
          update.sh
        utils.sh
      .git/
      README.md
      update.sh
    ```

## Initial Project Setup

1. Create the **pi-commander** repo; Refer to
   [Git Aliases and Init](../../book/1c7f4380-1eb3-426a-8805-3c521cea585b.md)
   as needed. You should have a new, virtually empty repo, potentially with a
   README.md file, and LICENSE file if you choose.
2. Enter the pi-commander folder and create the root update.sh (use your
   favorite code editor; You can also do things from the terminal if you fancy)

    ```bash
    cd pi-commander
    echo '#!/bin/bash' > update.sh
    chmod +x update.sh
    ```
    NOTE: from now on, commands will assume you're at project-root, pi-commander
3. Create the `pi-commander/bash` folder and utils.sh file inside that

    ```bash
    mkdir bash
    echo '#!/bin/bash' > bash/utils.sh
    chmod +x bash/utils.sh
    ```
    Technically, this utils.sh file doesn't have to be made executable, as we
    intend to source it in other scripts (vs execute)

4. Create the `pi-commander/bash/wallpaper` folder and update.sh file inside

    ```bash
    mkdir bash/wallpaper
    echo '#!/bin/bash' > bash/wallpaper/update.sh
    chmod +x bash/wallpaper/update.sh
    ```

5. For the three `*.sh` files just created, add contents respectively; For more
   details on this pattern, refer to
   [Bash Functions](../../book/e32f3180-280b-4c09-bdb3-9a5137dd1634.md)

    pi-commander/bash/utils.sh
    ```bash
    #!/bin/bash
    # Exit immediately if a command exits with a non-zero status.
    set -e

    # runMain: in each script, use the pattern:
    #
    # THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    # source $THIS_DIR/../utils.sh
    #
    # function main() {
    #   ...
    # }
    #
    # runMain "$@"
    #
    function runMain() {
      local component="$( basename $THIS_DIR)"
      local action="$( basename $0 )"
      echo "$(date '+%Y-%m-%d %T') [START] $action {$component}"
      main "$@"
      echo "$(date '+%Y-%m-%d %T') [COMPLETE] $action {$component}"
    }
    ```

    pi-commander/bash/wallpaper/update.sh
    ```bash
    #!/bin/bash
    THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source $THIS_DIR/../utils.sh

    function main() {
      echo "Setting wallpaper..."
    }

    runMain "$@"
    ```

    pi-commander/update.sh
    ```bash
    #!/bin/bash
    THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source $THIS_DIR/bash/utils.sh

    function main() {
      echo "Starting the Pi Commander Update!"

      update wallpaper
    }

    function update() {
      $THIS_DIR/bash/$1/update.sh
    }

    runMain "$@"
    ```

6. If everything went well this far, you should be able to run the project-root
   `update.sh`

    ```bash
    ./update.sh
    ```
    You should see output like this
    ```log
    2020-12-31 14:24:58 [START] update.sh {pi-commander}
    Starting the Pi Commander Update!
    2020-12-31 14:24:58 [START] update.sh {wallpaper}
    Setting wallpaper...
    2020-12-31 14:24:58 [COMPLETE] update.sh {wallpaper}
    2020-12-31 14:24:58 [COMPLETE] update.sh {pi-commander}
    ```

7. Add all the new files to git, commit, and push (if you setup remote)

    ```bash
    git add .
    git commit -m 'bash: create initial structure'
    ```
    If you have remote setup, and want to push
    ```bash
    git push origin <branch-name>
    ```

[**Initial bash setup complete!**](https://github.com/tveal/template-pi-commander/compare/v0...v0.0-getting-started)

### What did we just do?

Think about it this way:
- We made a single entry point, `pi-commander/update.sh`, that can eventually be
  called on a schedule, to update our Raspberry Pi
- We now have a pattern to scale out bash scripts to provision various tools we
  want on the Raspberry Pi
- Being tracked in git, we can push these changes to remote, and pull them onto
  the Raspberry Pi
- Bonus: We have some helpful logging :)

This is just the beginning...

## Following Sections

On the following sections in this chapter, we'll be making incremental changes
to this pi-commander repo. I'll **omit the repetitive commit-and-push steps**,
but strongly encourage you to follow the commit-and-push steps at the end of
_each section_ that makes changes. The pattern:

```bash
git add .
git commit -m '<replace me with appropriate commit message about change>'
git push origin <branch-name>
```

You may choose a safer way to add files, one-by-one, so you're aware of each
change. This is easy from VSCode in the visual diff viewer, or you can do it
from command-line

See diff in terminal
```bash
git diff <file>
```

Add specific file
```bash
git add <file>
```