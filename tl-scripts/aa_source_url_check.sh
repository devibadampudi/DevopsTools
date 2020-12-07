VM_username=`terraform output VM_username`
public_ip_address=`terraform output VM_public_ip_address`
VM_password=`terraform output VM_Password`
url=`terraform output aa_static_app_fqdn`

echo -e "script = <<-EOH\nSet-ItemProperty -Path \"HKLM:/SOFTWARE/Microsoft/Internet Explorer/Main\" -Name \"DisableFirstRunCustomize\" -Value 2\n\$data = Invoke-WebRequest -Uri $url\nif(Test-Path  $USER_ANSWER)\n{\n@(\$data.ParsedHtml.getElementsByTagName(\"table\"))[0].OuterHTML | Set-Content -Path c:/users/static.html\nGet-Content c:/users/static.html | Where-Object {\$_ -notmatch '</TH>'} | %{((\$_ | out-string) -replace '(</?t[rdh])[^>]*(/?>)|(?:<[^>]*>)','') -replace \"\`r\`n\",'' -replace ' ',''} | ? {\$_.trim() -ne \"\" } > c:/users/static.txt" > aa.rb
echo -e "Import-Csv -path $USER_ANSWER |Foreach-Object {  foreach (\$property in \$_.PSObject.Properties) { Write-Output  \$property.Value } }  | %{((\$_ | out-string) -replace \"\`t\",\"\`n\" -replace ':', \"\`n\" -replace ';',\"\`n\" -replace \"\`r\`n\",'')} > c:/users/csv.txt\nif(diff (Get-Content c:/users/static.txt) (Get-Content c:/users/csv.txt)) {echo \"files are different\"} else {echo true}\n}\nelse {echo \"File $USER_ANSWER not exist\"}\nEOH\ndescribe powershell(script) do\nits(\"stdout\") { should eq \"true\\\r\\\n\" }\nend" >> aa.rb

inspec exec aa.rb --chef-license=accept-silent  --reporter=json -t winrm://$VM_username@$public_ip_address  --password $VM_password  | grep -v WARN | jq .profiles[].controls[].results[] |  if `grep -qiw passed`; then echo -e "~{\n\"status\": \"passed\",\n\"message\": \"Provided File $USER_ANSWER is exist and mached with static app url\"\n}~"; else  echo -e "~{\n\"status\": \"failed\",\n\"message\": \"Either $USER_ANSWER file does not exist or $USER_ANSWER file content is not matched with static app \"\n}~"; fi

