#!/bin/env bash
LOCATION="${1:-de}"
echo Deleting machine for location $LOCATION
./ansiblew -i localhost, -e "location=$LOCATION" -e "new_machine=true" site.yaml --vault-password-file vault_file --tags=delete,pre
