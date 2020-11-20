134d9622-bae1-47f6-bec6-8dac5da9d798
# SSH Keys

**Named SSH public/private key pair**

1. Generate new key pair, with a comment and filename

    ```
    ssh-keygen -t rsa -C "MyCoolUsernameOrComment" -f ~/.ssh/customName_rsa
    ```

    For added security, set a passphrase when it prompts. If you do set a
    passphrase, every time you authenticate, you'll have to enter the passphrase
    OR you can run `ssh-add ~/.ssh/customName_rsa`, enter the passphrase, and it
    will stay unlocked until you reboot.

2. Update/Create config file `~/.ssh/config` for hostname(s) tied to the key:

    ```
    host github.com
        HostName github.com
        IdentityFile ~/.ssh/customName_rsa
        User <your username>
    ```
