e32f3180-280b-4c09-bdb3-9a5137dd1634

# Bash Functions

Bash scripts are linear. If you need to define variables for reuse, you must
define them before use - nothing new here; However, sometimes we want to write
code in a way that makes reading easier. For example, if I need a very complex
set of instructions defined, I don't want to read through all the steps before
seeing what the main gist of the script does. A learning approach
- tossed in the deep end to find the shallows
- VS
- wade in the shallows then selectively dive into deeper waters

One way to "wade in the shallows" first is to read the script _backwards_; From
bottom to top. Another way, is by bash **functions**.

```bash
#!/bin/bash

function main() {
  echo "Hi there!"
}

main "$@"
```

This sample doesn't buy us anything new _yet_, but it's a pattern to get used
to. Some takeaways:
- define a `main` function at the **top** of your script, that will be the
  "shallow waters", or high-level overview
- call the `main` function at the **end** of your script
- pass all command line args to the main function

NOTE: it is a VERY good idea to quote all your variables in bash scripts. There
are edge cases, but if in doubt, quote-first. Space delimiters can bite in many
unexpected ways.

Let's get a little fancier

```bash
#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
set -e

function main() {
  whereAmI
}

function whereAmI() {
  local here="$(pwd)"
  local home="/home/coder"
  if [ "$here" == "$home" ]; then
    echo "You are home!"
  else
    echo "Hmm. You're away from home: $here"
  fi
}

main "$@"
```

Takeaways
- Keep high-level `main` at the top, with minimized syntax
- Expand complexity in abstracted functions further down in the file
- Don't forget the `set -e` at the top if you want safer error handling

## Advanced: Import Utility Functions

Let's say you want to write a collection of scripts, but want many/all of them
to reuse the same config and utility functions.

For example's sake, let's work with a folder structure:
```
myTools/
  bash/
    greetings/
      main.sh
    goodbyes/
      main.sh
    utils.sh
  runAll.sh
```

Start with the utils, `myTools/bash/utils.sh`; Say we want:
- All scripts to default to `set -e` error handling
- Log which script is running, with timestamps

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

Now, create `myTools/bash/greetings/main.sh`:

```bash
#!/bin/bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/../utils.sh

function main() {
  echo "Hi there!"
}

runMain "$@"
```

Next, create `myTools/bash/goodbyes/main.sh`:

```bash
#!/bin/bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/../utils.sh

function main() {
  echo "Bye there!"
}

runMain "$@"
```

Last, create `myTools/runAll.sh`:

```bash
#!/bin/bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/bash/utils.sh

function main() {
  run greetings
  run goodbyes
}

function run() {
  # Note: this works when there's NO spaces in $1
  $THIS_DIR/bash/$1/main.sh
}

runMain "$@"
```

Make sure you've made all the `*.sh` files executable; You can now run the
`myTools/runAll.sh` script
```
coder@machine:~/myTools$ ./runAll.sh 
2020-12-31 13:38:02 [START] runAll.sh {myTools}
2020-12-31 13:38:02 [START] main.sh {greetings}
Hi there!
2020-12-31 13:38:02 [COMPLETE] main.sh {greetings}
2020-12-31 13:38:02 [START] main.sh {goodbyes}
Bye there!
2020-12-31 13:38:02 [COMPLETE] main.sh {goodbyes}
2020-12-31 13:38:02 [COMPLETE] runAll.sh {myTools}
```
