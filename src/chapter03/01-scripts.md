ea41757f-b609-427b-b0d3-464ae55df1db

# Bash Scripts

Bash is a common shell on Linux/Unix systems. On most modern Linux systems, your
terminal is using bash, so any command-line you enter is going through bash,
even if you're launching a non-bash tool/app.

From a linux terminal, you can run an echo command like so:

```bash
echo "Hi there!"
```

To make a bash script, simply make a file such as `myScript.sh` with contents
like:

```bash
#!/bin/bash
echo "Hi there!"
```

You should make this file executable, which can be done from command-line

```bash
chmod +x myScript.sh
```

Then you can run the script
```bash
./myScript.sh
```

Now you can additional commands to `myScript.sh`

```bash
#!/bin/bash
echo "Hi there!"
echo "You are here: $(pwd)"
```

## Error Handling

**BEWARE**: Bash scripts by default do NOT halt on error!

```bash
#!/bin/bash
echo "Hi there!"
fakeCommand
echo "You are here: $(pwd)"
```

The script above will still run all 3 commands
```
coder@machine:~$ ./myScript.sh
Hi there!
bash: fakeCommand: command not found
You are here: /home/coder
```

Depending on your needs, this may or may not be desired. I'll cover two ways to
solve this:

1. **Messy** - Chain commands together in a conditional chain

    ```bash
    #!/bin/bash
    echo "Hi there!" \
      && fakeCommand \
      && echo "You are here: $(pwd)"
    ```
    This will conditionally run proceeding commands if the previous was a
    success; but it could get real messy in a large set of commands

2. **Clean** - Use a shell option to change error handling

    ```bash
    #!/bin/bash
    set -e

    echo "Hi there!"
    fakeCommand
    echo "You are here: $(pwd)"
    ```
    The `set -e` command makes the shell "Exit immediately if a command exits
    with a non-zero status."; Run `set --help` for more info

    If you need to toggle back and forth with exit behavior, use `set +e` to get
    back to default behavior
