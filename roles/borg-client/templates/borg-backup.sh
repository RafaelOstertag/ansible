#!/bin/sh

set -u

{% if ansible_distribution == 'OpenBSD' %}
PATH="/usr/local/bin:${PATH}"
export PATH
HOME="/root"
export HOME
{% endif %}

BORG_REPO="borg@borg.kruemel.home:root"
export BORG_REPO
BORG_CACHE_DIR=/var/cache/borg
export BORG_CACHE_DIR
BORG_EXIT_CODES=modern
export BORG_EXIT_CODES

log_error() {
    echo "$*" >&2
}

check_repo() {
    borg check --repository-only
}

init_repo() {
    borg init --encryption=none
}

initialize_repo_if_required() {
    if ! check_repo; then
        if ! init_repo; then
            log_error "cannot initialize repo"
            exit 1
        fi

        if ! check_repo; then
            log_error "repo initialized but cannot be checked"
            exit 2
        fi
    fi
}

## main

initialize_repo_if_required

borg create --verbose \
    --list \
    --filter CE \
    --stats \
    --compression lz4 \
{% if 'ec2_borg_clients' in group_names %}
    --upload-ratelimit 5000 \
{% endif %}
    --exclude-from /usr/local/etc/borg-exclude \
    ::'{now}' \
    /
errval=$?
if [ ${errval} -ne 0 -a \! \( ${errval} -ge 100 -a ${errval} -le 127 \) ]; then
    log_error "Error while backing up. Error code: ${errval}"
    exit 4
fi

borg prune --verbose \
    --stats \
    --keep-daily 7 \
    --keep-weekly 4 \
    --keep-monthly 6 \
    --keep-yearly 2
errval=$?
if [ ${errval} -ne 0 ]; then
    log_error "Error while pruning. Error code: ${errval}"
    exit 5
fi

borg compact --verbose
errval=$?
if [ ${errval} -ne 0 ]; then
    log_error "Error while compacting. Error code: ${errval}"
    exit 5
fi
