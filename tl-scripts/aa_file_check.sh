VM_username=`terraform output VM_username`
public_ip_address=`terraform output VM_public_ip_address`
VM_password=`terraform output VM_Password`

inspec shell --chef-license=accept-silent  --reporter=json  -c "describe file('$USER_ANSWER') do it { should exist } end" -t winrm://$VM_username@$public_ip_address  --password $VM_password | grep -v WARN | jq .profiles[].controls[].results[] | if `grep -qiw passed`; then echo -e "~{\n\"status\": \"passed\",\n\"message\": \"$USER_ANSWER is exist in system\"\n}~"; else  echo -e "~{\n\"status\": \"failed\",\n\"message\": \"Enterd file $USER_ANSWER is not exist in system\"\n}~"; fi

