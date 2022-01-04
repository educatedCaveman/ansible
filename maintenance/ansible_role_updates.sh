#!/bin/bash

if [ $# -eq 0 ]
then
    echo "no arguments given. exiting..."
    exit 1
fi
GIT_DIR="$1"
UPDATE_DIR="${GIT_DIR}/maintenance/role_updates"
# allowable seconds between commit timestamp and current timestamp
WINDOW=3600

# determine if the commit was a recent one or not
# I don't want it to run the playbooks when invoked via the schedule
# in the event the last update was to a role
GIT_TS=$(git -C $GIT_DIR --no-pager log -m -1 --format=%ct)
LOCAL_TS=$(date +%s)
TS_DIFF=$(( ${LOCAL_TS} - ${GIT_TS} ))
echo "$TS_DIFF seconds have elapsed between now and the last commit"
if (( $TS_DIFF > $WINDOW ))
then
    echo "more than $WINDOW seconds have elapsed since the last commit"
    echo "will not run any playbooks"
    exit 0
else
    echo "within window.  will examine git, and maybe run playbooks"
fi

# 1. determine the most recent git changes
# 2. filter the changes that would be the roles
# 3. reduce to a list of unique playbooks
GIT_LINES=( $(git -C $GIT_DIR --no-pager log -m -1 --name-only | grep "^roles" | sort -u) )

for playbook_file in "${GIT_LINES[@]}"
do
    role_name=$(echo ${playbook_file} | cut -d '/' -f2)
    playbook_path="${UPDATE_DIR}/${role_name}.yml"
    echo  "checking if '$playbook_path' exists..."
    if [ -e ${playbook_path} ]
    then
        echo "playbook exists.  will run..."
        ansible-playbook ${playbook_path}
    else
        echo "${playbook_path} playbook doesn't exist. skipping."
    fi
done