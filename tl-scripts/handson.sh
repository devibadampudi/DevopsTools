#USER_ANS=`echo $USER_ANSWER | tr -d []`
VM_username=`terraform output VM_username`
public_ip_address=`terraform output public_ip_address`
VM_password=`terraform output VM_password`
inspec shell --chef-license=accept-silent  --reporter=json  -c "describe file('$USER_ANSWER') do it { should exist } end" -t winrm://$VM_username@$public_ip_address  --password $VM_password | grep -v WARN | jq .profiles[].controls[].results[] | if `grep -qiw passed`; then echo -e "~{\n\"status\": \"passed\",\n\"message\": \"$USER_ANSWER is exist in system\"\n}~"; else  echo -e "~{\n\"status\": \"failed\",\n\"message\": \"Enterd file $USER_ANSWER is not exist in system\"\n}~"; fi

#echo -e "script = <<-EOH\nInvoke-WebRequest -Uri \"https://www.staticapps.org\" | select -ExpandProperty Content | Out-File d:/url2i.html\nInvoke-WebRequest -Uri \"https://www.staticapps.org\" | select -ExpandProperty Content | Out-File d:/url3.html\nif((Test-Path  d:/url2.html) -And (Test-Path  d:/url3.html)) {if (\$(Get-FileHash d:/url2.html).Hash -eq \$(Get-FileHash d:/url3.html).Hash) { Write-Output \"true\"} else {Write-Output \"false\" }} else {Write-Output false}\nEOH\ndescribe powershell(script) do\nits(\"stdout\") { should eq \"true\\\r\\\n\" }\nend" > abc.rb
#inspec exec abc.rb --chef-license=accept-silent  --reporter=json -t winrm://$VM_username@$public_ip_address  --password $VM_password  | grep -v WARN | jq .profiles[].controls[].results[] |  if `grep -qiw passed`; then echo -e "~{\n\"status\": \"passed\",\n\"message\": \"two files are same\"\n}~"; else  echo -e "~{\n\"status\": \"failed\",\n\"message\": \"sourece file are not exist or two files are not matched\"\n}~"; fi


#if test -f "$USER_ANS"; then
#echo -e "~{\n\"status\": \"passed\",\n\"message\": \"$USER_ANS file is exist\"\n}~"
#else
#echo -e "~{\n\"status\": \"failed\",\n\"message\": \"$USER_ANS file not found\"\n}~";
#fi
~     
