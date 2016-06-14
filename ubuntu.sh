#!/usr/bin/env bash
function set_or_create {
    # set_or_create key value file
    if grep -e "^#\?$1" $3; then
        sed -i -E 's|^#?'"$1"'[[:space:]].*|'"$1 $2"'|' $3
    else
        echo $1 $2 >> $3
    fi
}

# Configure ssh
mkdir -p ~/.ssh/
mkdir ~root/.ssh/

# Copy over keys for somewhat secure machines
cp master_console_keys ~/.ssh/master_console_keys
cp master_console_keys ~root/.ssh/master_console_keys

# Let sshd use these, and other, public keys to authenticate users. Disable password login.
set_or_create AuthorizedKeysFile "%h/.ssh/authorized_keys %h/.ssh/authorized_keys.sync %h/.ssh/master_console_keys" /etc/ssh/sshd_config
set_or_create ChallengeResponseAuthentication no /etc/ssh/sshd_config
set_or_create PasswordAuthentication no /etc/ssh/sshd_config
set_or_create UsePAM no /etc/ssh/sshd_config
