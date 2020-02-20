printf "\nWhat is the IP you seek?\n"
read IP

mgmt_cli -r true show domains limit 500 --format json | jq --arg IP "$IP" -r '.objects[] | "mgmt_cli -r true -d " + .name + " show objects ip-only true filter " + $IP + " --format json" ' >> search.sh

mgmt_cli -r true show mdss details-level full --format json | jq -r --arg IP "$IP" '.objects[]."global-domains"[] | "mgmt_cli -r true -d " + .name + " show objects filter " + $IP + " --format json" ' >> search.sh
chmod +x search.sh
/bin/bash search.sh >> $IP-domain_search.txt
rm search.sh
printf "\nResults of your search are in $IP-domain_search.txt\n"
