<# first in Active Directory I created New Organozation Unit, Named it 'Not-Active_Computers', To put not used computers in it #>
<# below the computer that is not used for that limit apply the further steps on #>
$No_Of_Months = 6
$d = (Get-Date).AddMonths(-$No_Of_Months)

<# Bring exception list file and put it variable #>
$filePath = "\\"server-name"\path\to\the\Exception-list.txt"
[System.Collections.ArrayList]$exception_list = Get-Content $filePath
<# Bring Not Used Computers for "EX: last 6 months" #>
[System.Collections.ArrayList]$Not_Used_Computers= Get-ADComputer -Filter '(LastLogonDate -lt $d)' -Properties LastLogonDate | ForEach-Object {$_.Name}

Write-host "All Devices :"
write-host $Not_Used_computers.count, "Devices `n-----------"
write-host $Not_Used_computers + "`n"

<# ------------------------------------------------------------------- #>
<# Exclude computers in Exception list. #>
<# Remove the Exception list Computers from Not Used Computers #>

$c= $exception_list.count

for($s=0 ; $s -lt $c ; $s++)
{   if ($exception_list[$s] -in $Not_Used_Computers)
    {
        $w = $exception_list[$s]
	$Not_Used_Computers.Remove("$w")
    }
}

write-host "Devices After Removing Servers from the list :"
write-host $Not_Used_computers.count, "Devices `n-----------"
write-host $Not_Used_computers + "`n"

<# ------------------------------------------------------------------- #>
<# Exclude "Not-Active-Computers" OU Computers. #>
<# Get list of computers inside "Not-Active_Computers" OU #>

$b=$Not_Used_Computers.count
[System.Collections.ArrayList]$OU= @()
for($d=0 ; $d -lt $b ; $d++)
  { 
    $z=$Not_Used_Computers[$d]
    $i="DistinguishedName -like "
    $v="CN=$z,OU=Not-Active-Computers,DC=CAIROMETRO,DC=LOCAL"
    $v=$v.Replace(" ",",")
    $m=" -AND (Name -like "
    $y="($i"+'"'+"$v"+'")'+"$m"+'"'+"$z"+'"'+")"
    $o= Get-ADComputer -Filter $y -Properties DistinguishedName | ForEach-Object {$_.Name}
    $OU=$OU+"$o"
  }

<# Remove the computers inside "Not-Active_Computers" OU #>

$t=$OU.count
for($n=0 ; $n -lt $t ; $n++)
{  if ($OU[$n] -in $Not_Used_Computers)
    {
        $u = $OU[$n]
	$Not_Used_Computers.Remove("$u")
    }
}

<# ------------------------------------------------------------------- #>
<# Move the rest of computers to and write document of old Users Data. #>

$x=$Not_Used_Computers.count

<# variable that have date and time in this format : 2023-09-16  05:21:47 PM #>
$current_dateAndtime = [datetime]::now.tostring("yyyy-MM-dd  hh+mm+ss tt")
$current_dateAndtime = $current_dateAndtime.Replace("+",":")
$current_date = [datetime]::now.tostring("yyyy-MM-dd")

if ($x -ne 0) {
"Run At : " + $current_dateAndtime + "`n---------------------------------" >>  "\\"server-name"\path\to\log\file\Computers_not-used-for-$No_Of_Months-months-$current_date.txt"
}

for($k=0 ; $k -lt $x ; $k++)
{
        $Not_Used_Computers[$k] = $Not_Used_Computers[$k].Replace(" ","")
	$Not_Used_Computers[$k] = $Not_Used_Computers[$k].Replace("+","")
	$j=$Not_Used_Computers[$k]
        $IP_Address = Get-ADComputer -Identity $j -Properties IPv4Address | ForEach-Object {$_.IPv4Address}
        $last_logon = Get-ADComputer -Identity $j -Properties LastLogonDate | ForEach-Object {$_.LastLogonDate}
	$DistName   = Get-ADComputer -Identity $j -Properties DistinguishedName | ForEach-Object {$_.DistinguishedName}
        "Device Name : $j `n" + "IP Address : $IP_Address `n" + "Last logon Date : $last_logon `n" + "old OU : $DistName `n" >> "\\"server-name"\path\to\log\file\Computers_not-used-for-$No_Of_Months-months-$current_date.txt"
        Move-ADObject -Identity "$DistName" -TargetPath "OU=Not-Active-Computers,DC=CAIROMETRO,DC=LOCAL"
}

write-host "Devices After Removing Devices From 'Not-Active-Computers' OU from the list:"
write-host $Not_Used_computers.count, "Devices `n-----------"
write-host $Not_Used_computers , "`n"
