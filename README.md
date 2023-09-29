📰 # Quarantine-Active-Directory-not-active-computers 
<picture>
  <img alt="Quarantine Not-Active-Computers from Active Directory" src="https://i.imgur.com/aG595ee.png">
</picture>

📂File 1 :
<# move not Active Computers to OU.ps1 #>

why writting this powershell script ?

1- in our company the active directory was full with computers that are not active
> Even deploying new OS on physical computer and naming the computer different name,
Then add it to Active Directory, so the old entity with the old name is left away in Active Directory. 

OR

> Entities "computers" that are corrupted or not used for a lot of time.

2- So this powershell script select all computers that their "last login date" exceed for example 6 moths -you can modify the number-
then move them to new Organization Unit (OU) named 'not-active_computer'

3- During this operation the script go to file named 'exception-list.txt'
that include ( servers , important devices ) names, That I don't want to be touched or moved
except those devices while running this script.

4- At the end create log file that contain
the computers that are moved to 'not-active_computer'
> name,

> last log on date,

> ip address,

> old OU. 'before moving'

5- Then the technical support guy will disable all the computers, if no complain occured in let's say 1 month,
then delete those computers.

<H4>GOD WILLING, after that we will have active directory clear of not active computers.
good end right.</H4>


📂File 2 :
<# Exception-list.txt #>

put the Servers & important devices here, that shouldn't be moved by this script.
(Those devices will be safe from this script)

📂File 3 :
<# Extra/get OU Computers count.ps1 #>

"Not Related but, extra feature if you want to count the computer in Specific OU in your Active Directory"

📜file 3 Credits : 
https://stackoverflow.com/questions/32484212/get-a-count-of-users-in-a-specific-ou-and-its-sub-ous
