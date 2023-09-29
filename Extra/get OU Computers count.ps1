<# this code is to get the number of computers in specific Organozation Unit 'OU' in Active Directory #>
<# replace : "OU=Not-Active-Computers,DC=my-Domain,DC=LOCAL" with OU "DistinguishedName" you want to count it's Computers #>
$ous = Get-ADOrganizationalUnit -Filter * -SearchBase "OU=Not-Active-Computers,DC=my-Domain,DC=LOCAL" | Select-Object -ExpandProperty DistinguishedName
$ous | ForEach-Object{
    [psobject][ordered]@{
        OU = $_
        Count = (Get-ADComputer -Filter * -SearchBase "$_").count
    }
}

<# 
Credits : Matt in
https://stackoverflow.com/questions/32484212/get-a-count-of-users-in-a-specific-ou-and-its-sub-ous
#>
