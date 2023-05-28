source config.sh

num_lines=$(wc -l < accounts.csv)
values1=($(cut -d ';' -f 1 accounts.csv | sed 's/ //g'))
values2=($(cut -d ';' -f 2 accounts.csv | sed 's/ //g'))
values3=($(cut -d ';' -f 3 accounts.csv | sed 's/ //g'))
values4=($(cut -d ';' -f 4 accounts.csv | sed 's/ //g'))
for (( i=1; i<$num_lines; i++ )); do

    pass="${values4[$i]}"
    first="${values1[$i]:0:1}"
	username="$first${values2[$i]}" 

    ssh -i $pathtokey $log@$ip "export OC_PASS="$pass""
    ssh -i $pathtokey $log@$ip "occ user:add --password-from-env --display-name="$username" $username"
done
