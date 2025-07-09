# Define your values
$domain = ""
$user = ""
$pass = ""
$ou = ""

# Convert password to secure string
$securePass = ConvertTo-SecureString $pass -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($user, $securePass)

# Join the domain
Add-Computer -DomainName $domain -Credential $cred -OUPath $ou -Restart
