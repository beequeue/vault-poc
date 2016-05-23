#!/bin/bash
#

# We need to pass the address because we're not using TLS
ADDR_PARAM="-address=http://192.168.99.100:8200"

# Convenience wrapper to vault CLI
function vault {
	docker exec -it vault vault "$@" 
}


docker-compose down
docker-compose up -d

#
# 1. Initialize the vault and obtain 3 of the 5 keys necessary to unseal
#

INIT=$(vault init $ADDR_PARAM)
echo "$INIT"
echo

KEY1=`echo "$INIT" | grep 'Key 1' | cut -d' ' -f3`
KEY2=`echo "$INIT" | grep 'Key 2' | cut -d' ' -f3`
KEY3=`echo "$INIT" | grep 'Key 3' | cut -d' ' -f3`

#
# 2. Unseal the vault
#

echo "Unsealing with key 1..."
vault unseal $ADDR_PARAM $KEY1
echo

echo "Unsealing with key 2..."
vault unseal $ADDR_PARAM $KEY2
echo

echo "Unsealing with key 3..."
vault unseal $ADDR_PARAM $KEY3
echo
