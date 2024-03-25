# Quarantine-Active-Directory-not-active-computers 
<dl>
  
<picture>
  <img alt="Quarantine Not-Active-Computers from Active Directory" src="https://i.imgur.com/aG595ee.png">
</picture>

<dt>📂File 1 : move not Active Computers to OU.ps1 </dt>
<dd><br>
  
why writting this powershell script ?
<br>
> In our company the active directory was full with computers that are not active <br>
> Even deploying new OS on physical computer and naming the computer different name,<br>
> Then add it to Active Directory, so the old entity with the old name is left away in Active Directory. <br>

OR

> Entities "computers" that are corrupted or not used for a lot of time.

<H4>Before Running this Script </H4> 

>Don't forget to create Organization Unit 'OU' in Active Directory Directly after in Domain-name container,
>
>and name it "Not-Active-Computers", so the path will be for-example:
>
>"OU=Not-Active-Computers,DC=my-Domain,DC=LOCAL" or "my-Domain.local/Not-Active-Computers"


> [!NOTE]<br>
> You MUST edit the script by your values of those variables :<br>
>
> $No_Of_Months : &ensp; he limit you want "when was last time the computer logged on the domain ?"<br>
> &ensp; &ensp; &ensp; &ensp;The limit you want of months default 6 months<br>
> $srv_name : &ensp; the server name or ip_address where you put the exception_list.txt file and where log file is created<br>
> $domin_pt1 : &ensp; first part of your domain name if your Domain name is "stc.local" ,then it's "stc"<br>
> $domin_pt2 : &ensp; second part of your domain name if your Domain name is "stc.local" ,then it's "local"<br>


<H4>GOD Willing, This powershell script will do the following :</H4>

1- Select all computers that their "last login date" exceed for example 6 months <br>
&ensp; &ensp;"You can modify the number : 3 months or whatever you want",<br>
&ensp; &ensp;Then move them to new Organization Unit (OU) named 'Not-Active-Computers'

2- During this operation the script :
> 2.1- The script go to file named 'exception-list.txt' <br>
> &ensp; &ensp; &ensp;that include ( servers , important devices ) names,<br>
> &ensp; &ensp; &ensp;That I don't want to be touched or moved "exclude those computers while running this script".

> 2.2- The script will ignore all the computers inside "Not-Active-Computers" OU <br>
> &ensp; &ensp; &ensp;when counting the computers that Need to be Moved.

3- Move computers should be moved, to "Not-Active-Computers" OU.

4- At the end it creates log file that contains computers moved to'Not-Active-Computers' OU folloing Data :
> name,<br>
> last log on date,<br>
> ip address,<br>
> old OU. 'before moving'

<H4> After Running this Script </H4>

You will disable all the computers in "Not-Active-Computers" OU , if no complain occured in let's say 1 month,
then delete those computers.
</dd>
<br>

$${\color{green}\Large GOD \space WILLING, \space after \space that \space we \space will \space have \space active \space directory}$$

$${\color{green}\Large clear \space of \space not \space active \space Computers.}$$

<br>
📜file 1 Credits : <br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; https://activedirectorypro.com/get-adcomputer-list-computers/ <br>
https://stackoverflow.com/questions/37603837/powershell-where-lastlogondate-is-over-90-days-from-today<br>
https://community.spiceworks.com/topic/2001760-powershell-script-for-enabled-users-lastlogondate-30-days/ <br>
https://activedirectorypro.com/last-logon-time/
<br>
<br>
<dt>📂File 2 : Exception-list.txt</dt>
<dd>
  &ensp; &ensp; &ensp;Put the important dvices here, that shouldn't be moved by this script.<br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; (Those devices will be safe from this script)
</dd>

<dt>📂File 3 : Extra/get OU Computers count.ps1</dt>
<dd>
&ensp; &ensp; &ensp;"Not Related but, extra feature if you want to count the the computers in Specific OU in your Active Directory"

&ensp;📜file 3 Credits : https://stackoverflow.com/questions/32484212/get-a-count-of-users-in-a-specific-ou-and-its-sub-ous
</dd>
</dl>
