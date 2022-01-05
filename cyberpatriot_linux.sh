echo -e "\e[0;46mThis script is dedicated to my uncle.\e[1;m"
##My uncle is in the ICU at the time of me writing this script. He is an engineer and I hope this would make him proud.

##Update: as of December 14th, 2021, my uncle has passed away. 

sleep 10

#To clear the terminal so it doesn't look messy, and so people know when a process is finished.
cont(){
	echo "\e[0;33mContinue to next task? [Y/N]\e[1;m"
	read contyn
	if [ "$contyn" = "N" ] || [ "$contyn" = "n"]; then
		echo "\e[0;33mAborting...\e[1;m"
		exit
	fi
	clear
}

cont

echo -e "\e[0;33mCreating backups of critical files...\e[1;m"

sleep 3

mkdir /Backups

#Backups the password directory
sudo cp /etc/passwd /Backups
##Backups the sudoers file.
sudo cp /etc/sudoers /Backups
##Backsups the log files
cp -r /var/log /Backups
##Backups shadow file
cp /etc/shadow /Backups
#backsup all home directories
cp -r /home/$x /Backups

cont


echo -e "\e[0;33mBeginning to update, upgrade and install applications needed for the system, answer the ReadME while you wait.\e[1;m"

sleep 3

sudo add-apt-repository -y ppa:libreoffice/ppa

wait

sudo apt update

wait

sudo apt upgrade

wait

sudo apt dist-upgrade -y

wait

sudo apt autoclean

wait

sudo killall firefox

wait

sudo apt-get --purge --reinstall install firefox -y

wait

sudo apt install clamtk -y

wait

sudo apt install rkhunter

wait

rkhunter --propupd

wait


cont


echo -e "\e[0;33mUpdate and upgrade completed, now beginning filescan...\e[1;m"

sleep 3

echo -e "\e[0;33mPreparing to scan and delete prohibited files.\e[1;m"


sleep 3

echo -e "\e[0;33mScanning for media files.\e[1;m"

sleep 3


#Will print out the filepath of what was found.
sudo find / -type f | grep ".mp3|.mp4|.wav|.mov"

sleep 3

echo -e "\e[0;33mDeleting media files.\e[1;m"

sleep 3

#Deletes the files
sudo find / -name "*.mp3" -type f -delete
sudo find / -name "*.mp4" -type f -delete
sudo find / -name "*.mov" -type f -delete
sudo find / -name "*.wav" -type f -delete

sleep 3

echo -e "\e[0;33mMedia files deleted, searching for images.\e[1;m"

sleep 3

#Prints out the file path to the files.
sudo find / -type f | grep ".png|.jpg|.jpeg"

echo -e "\e[0;33mImages found, beginning deletion.\e[1;m"

sleep 3

#Deletes the files
find / -name "*.png" -type f -delete
find / -name "*.jpg" -type f -delete
find / -name "*.jpeg" -type f -delete

echo -e "\e[0;33mImages deleted, searching for other files. Please delete manually to verify that these are not essential.\e[1;m]"

sleep 3

sudo find / -type f | grep "*.tar.gz|*.php|*backdoor|*backdoor.php"

sleep 3


echo -e "\e[0;33m Scan completed.\e[1;m"

cont

echo -e "\e[0;33m Setting up firewall...\e[1;m"

sleep 3

sudo apt install ufw 
ufw enable

echo -e "\e[0;33m Firewall setup complete.\e[1;m"

sleep 3

cont

echo -e "\e[0;33m Starting antivirus scans...\e[1;m"

sleep 3

echo -e "\e[0;33m Clamscan!\e[1;m"

sleep 2

systemctl stop clamav-freshclam
wait
freshclam --stdout
wait
systemctl start clamav-freshclam
wait
clamscan -r --remove /home/USER
wait

echo -e  "\e[0;33m Clamscan finished.\e[1;m"

sleep 1

echo -e "\e[0;33m Beginning rkhunter scan...\e[1;m"

sleep 1

rkhunter --update
wait
rkhunter -c --enable all --disable none

echo -e "\e[0;33m rkhunter scan complete. \e[1;m"

sleep 3

cont

echo -e "\e[0;33m Booting up Liberty Prime to delyeet mininukes into any malicious software... \e[1;m"

sleep 3

echo -e "\e[0;31m Liberty Prime is online...\e[1;m"

echo -e "\e[0;37m Mission...\e[1;m"

echo -e "\e[0;35m The destruction of all malicious software!\e[1;m"

dpkg -l | grep john >>output.log
if [ $? -eq 0 ];
then 
	echo -e "\e[0;31m Password cracker John the Ripper detected...Democracy is non negotiable! *BOOOOOM* \e[1;m"
	sleep 3
	sudo apt autoremove -y --purge john >> output.log
	wait
	echo -e "\e[0;31m America will never fall to malware invasion!\e[1;m"
	sleep 3
else 
	echo -e "\e[0;31m John the Ripper threat not detected.\e[1;m"
	sleep 3

fi

wait

dpkg -l | grep hydra >>output.log
if [ $? -eq 0];
then 
	echo -e "\e[0;31m Login cracker Hydra detected...Anchorage will be liberated!\e[1;m"
	sleep 3
	sudo apt autoremove -y --purge hydra >> output.log
	sleep 3
else 
	echo -e "\e[0;31 Login cracker Hydra not found. America prevails!\e[1;m"
	sleep 3
fi

dpkg -l | grep ngind >> output.log
if [ $? -eq 0 ];
then
	echo -e "\e[0;31 NGIX found...terminating...\e[1;m"
	sudo apt autoremove -y --purge nginx >> output.log
	sleep 3
else
	echo -e "\e[0;31 NGIX has not been found.\e[1;m"
	sleep 3
fi

if [ -d /etc/samba ];
then
	read -p -e  "\e[0;31 Samba has been found, remove?[Y/N]:\e[1;m   " a
	if [$a = y ];
	then 
	sudo apt autoremove --purge -y samba >> output.log
	wait
	sudo apt autoremove --purge -y samba >> output.log 
	wait
	echo -e "\e[0;31 Samba has been removed.\e[1;m"
	else 
		sed -i '82 i\restrict anonymous =2' /etc/samba/smb.conf
	fi
	
	echo -e "\e[0;31 Samba has not been found.\e[1;m"
	sleep 1


read -p "\e[0;33mAre there any users you would like to add?[Y/N]:\e[1;m" a
while [$a = y]
do
	read -p "Enter name of the user:" user
	useradd $user 
	mkdir /home/$user
	read -p  "Any more users that you would like to add?[Y/N]:" a
done

cont

echo -e "\e[0;33m Changing passwords to CyberP@triot1234 ...\e[1;m"

cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 > users

hUSER=`cut -d: -f1,3 /etc/passwd | egrep ':[0]{1}$' | cut -d: -f1`

echo -e "\e[0;33m $hUSER is a hidden user.\e[1;m"

sleep 3

sed -i '/root/ d' users

PASS='CyberP@triot1234'
for x in `cat users`
do
	echo -e "$PASS\n$PASS" | passwd $x >> output.log
	echo -e "Password for $x has been changed."
	chage -M 90 -m 7 -W 15 $x
done

cont

echo -e "\e[0;33m Setting password policy...\e[1;m"

sleep 1

echo -e "\e[0;33m Downloading CrackLib for password management. \e[1;m"

sleep 1

sudo apt install libpam-cracklib

wait

echo -e "\e[0;33m Cracklib installed, setting password policies...\e[1;m"

	sed-i.bak -e 's/PASS_MAX_DAYS\t[[:digit:]]\+/PASS_MAX_DAYS\t90/' /etc/login.defs
	sed -i -e 's/PASS_MIN_DAYS\t[[:digit:]]\+/PASS_MIN_DAYS\t10/' /etc/login.defs
	sed -i -e 's/PASS_WARN_AGE\t[[:digit:]]\+/PASS_MIN_DAYS\t10/' /etc/login.defs
	sed -i -e 's /difok=3\+/difok=3 ucredit=-1 lcredit=-1 dcredit=-1  ocredit=-1/' /etc/pam.d/common-password

wait

echo -e "\e[0;33mm Deleting users...you will have to specify which ones to delete.\e[1;m"

for x in 'cat users' 
do
	read  -p "Is $x a valid user? [Y/N]; " a
	if [ $a = n ];
	then 
		mv /home/$x /home/dis_$x
		sed -i -e "/$x/ s/^#*/#/"
		sleep 1
	fi
done
pause


cont


echo -e "\e[0;33mm Adding admins...please specify.\e[1;m"

sleep 3

for x in cat users
do
	read -p "\e[0;33mm Make $x admin? [Y/N]\e[1;m" a
	if [$a = y]
	then
		sudo usermod -a -G adm $x

		sudo usermod -a -G sudo $x

	else

		sudo deluser $x adm

		sudo deluser $x sudo

	fi

done

cont

echo "\e[0;33mm Script completed.\e[1;m"


