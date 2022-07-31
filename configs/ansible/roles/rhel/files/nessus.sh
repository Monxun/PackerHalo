#!/bin/bash 

sudo su

# //////////////////////////////////////////////////////////////////////////////////////////////////////
# NESSUS
# NESSUS SCANNER INSTALL & CONFIGURE (pg. 38)
# *** DOWNLOAD NESSUS SCANNER LOCALLY FROM S3 using aws cli to /opt directory

# rpm -ivh Nessus[name of .rmp file]
/opt/nessus/sbin/nessuscli mkcert

# *** ENTER PROMPT AUTOMATION FOR NESSUS CERTS BELOW...

# 

cat > nessus-install.sh <<EOF
#!/bin/bash

###Script for installing Nessus scanner on CMPS/AIP RHEL7 clients.

###Created by Tom Chattle - 2020-01-17
#v1.0 - Initial release
#v1.1 - Variablised aws cli

############################################################################
############################## Change variables below: ##############################
############################################################################
RED='\033[31;1m'
GRN='\033[32;1m'
CYN='\033[36;1m'
ORN='\033[38;5;208m'
NC='\033[0m' # No Color
AWS=$(which aws)
############################################################################
############# Do not change below this point unless you actually know what you're doing ###############
############################################################################

# Gather required variables
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
read -p "Is this the primary Nessus scanner? (y/n): "  ScannerNum
read -p "Enter password for Nessus admin account: " NessusPW
read -p "Enter the Environment code (e.g. C116): " ENV
ENVUpper=$(echo $ENV | awk '{print tolower($0)}')
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Get latest version available in S3
LatestVersion=$(aws s3 ls s3://software-installable-bin/Nessus/ | cut -d ' ' -f 6 | grep .rpm | sort -V | tail -n 1)
echo "Latest version in S3: $LatestVersion"
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Download
$AWS s3 cp s3://software-installable-bin/Nessus/$LatestVersion /root/ | tee -a /root/nessusinstall.log
	if [ $? == 0 ]; then
		echo -e "${GRN}Nessus Scanner downloaded${NC}" | tee -a /root/nessusinstall.log
	else
		echo -e "${RED}Download failed${NC}" | tee -a /root/nessusinstall.log
		exit 1
    fi
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Install
yum install -y /root/$LatestVersion --nogpgcheck | tee -a /root/nessusinstall.log
	if [ $? == 0 ]; then
		echo -e "${GRN}Nessus Scanner installed${NC}" | tee -a /root/nessusinstall.log
	else
		echo -e "${RED}Install failed${NC}" | tee -a /root/nessusinstall.log
		exit 1
	fi
systemctl daemon-reload | tee -a /root/nessusinstall.log
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Set as managed by Security Centre
/opt/nessus/sbin/nessuscli fetch --security-center | tee -a /root/nessusinstall.log
	if [ $? == 0 ]; then
		echo -e "${GRN}Set Scanner to be managed by Security Centre${NC}" | tee -a /root/nessusinstall.log
	else
		echo -e "${RED}Failed to set Scanner to be managed by Security Centre${NC}" | tee -a /root/nessusinstall.log
		exit 1
	fi
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Create Nessus Admin user
if [[ $ScannerNum == "y" || $ScannerNum == "Y" || $ScannerNum == "yes" || $ScannerNum == "Yes" ]]; then
	NessusUser=$(echo $ENVUpper)nessus01
    (echo $NessusPW; echo $NessusPW; echo y; echo  ; echo y) | /opt/nessus/sbin/nessuscli adduser $NessusUser | tee -a /root/nessusinstall.log
		if [ $? == 0 ]; then
			echo -e "${GRN}User: $NessusUser created${NC}" | tee -a /root/nessusinstall.log
		else
			echo -e "${RED}Failed to create $NessusUser ${NC}" | tee -a /root/nessusinstall.log
		fi
else
    NessusUser=$(echo $ENVUpper)nessus02
    (echo $NessusPW; echo $NessusPW; echo y; echo  ; echo y) | /opt/nessus/sbin/nessuscli adduser $NessusUser | tee -a /root/nessusinstall.log
		if [ $? == 0 ]; then
			echo -e "${GRN}User: $NessusUser created${NC}" | tee -a /root/nessusinstall.log
		else
			echo -e "${RED}Failed to create $NessusUser ${NC}" | tee -a /root/nessusinstall.log
		fi
fi
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
Below is a script for installing nessus scanner on CMPS/AIP RHEL7 clientsIn here, press “i” to insert text

Paste following below
###########################################################################

#!/bin/bash

###Script for installing Nessus scanner on CMPS/AIP RHEL7 clients.

###Created by Tom Chattle - 2020-01-17
#v1.0 - Initial release
#v1.1 - Variablised aws cli

############################################################################
############################## Change variables below: ##############################
############################################################################
RED='\033[31;1m'
GRN='\033[32;1m'
CYN='\033[36;1m'
ORN='\033[38;5;208m'
NC='\033[0m' # No Color
AWS=$(which aws)
############################################################################
############# Do not change below this point unless you actually know what you're doing ###############
############################################################################

# Gather required variables
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
read -p "Is this the primary Nessus scanner? (y/n): "  ScannerNum
read -p "Enter password for Nessus admin account: " NessusPW
read -p "Enter the Environment code (e.g. C116): " ENV
ENVUpper=$(echo $ENV | awk '{print tolower($0)}')
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Get latest version available in S3
LatestVersion=$(aws s3 ls s3://software-installable-bin/Nessus/ | cut -d ' ' -f 6 | grep .rpm | sort -V | tail -n 1)
echo "Latest version in S3: $LatestVersion"
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Download
$AWS s3 cp s3://software-installable-bin/Nessus/$LatestVersion /root/ | tee -a /root/nessusinstall.log
	if [ $? == 0 ]; then
		echo -e "${GRN}Nessus Scanner downloaded${NC}" | tee -a /root/nessusinstall.log
	else
		echo -e "${RED}Download failed${NC}" | tee -a /root/nessusinstall.log
		exit 1
	fi
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Install
yum install -y /root/$LatestVersion --nogpgcheck | tee -a /root/nessusinstall.log
	if [ $? == 0 ]; then
		echo -e "${GRN}Nessus Scanner installed${NC}" | tee -a /root/nessusinstall.log
	else
		echo -e "${RED}Install failed${NC}" | tee -a /root/nessusinstall.log
		exit 1
	fi
systemctl daemon-reload | tee -a /root/nessusinstall.log
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Set as managed by Security Centre
/opt/nessus/sbin/nessuscli fetch --security-center | tee -a /root/nessusinstall.log
	if [ $? == 0 ]; then
		echo -e "${GRN}Set Scanner to be managed by Security Centre${NC}" | tee -a /root/nessusinstall.log
	else
		echo -e "${RED}Failed to set Scanner to be managed by Security Centre${NC}" | tee -a /root/nessusinstall.log
		exit 1
	fi
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Create Nessus Admin user
if [[ $ScannerNum == "y" || $ScannerNum == "Y" || $ScannerNum == "yes" || $ScannerNum == "Yes" ]]; then
	NessusUser=$(echo $ENVUpper)nessus01
    (echo $NessusPW; echo $NessusPW; echo y; echo  ; echo y) | /opt/nessus/sbin/nessuscli adduser $NessusUser | tee -a /root/nessusinstall.log
		if [ $? == 0 ]; then
			echo -e "${GRN}User: $NessusUser created${NC}" | tee -a /root/nessusinstall.log
		else
			echo -e "${RED}Failed to create $NessusUser ${NC}" | tee -a /root/nessusinstall.log
		fi
else
    NessusUser=$(echo $ENVUpper)nessus02
    (echo $NessusPW; echo $NessusPW; echo y; echo  ; echo y) | /opt/nessus/sbin/nessuscli adduser $NessusUser | tee -a /root/nessusinstall.log
		if [ $? == 0 ]; then
			echo -e "${GRN}User: $NessusUser created${NC}" | tee -a /root/nessusinstall.log
		else
			echo -e "${RED}Failed to create $NessusUser ${NC}" | tee -a /root/nessusinstall.log
		fi
fi
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Start nessusd service
systemctl start nessusd | tee -a /root/nessusinstall.log
	if [ $? == 0 ]; then
		echo -e "${GRN}Nessus service started${NC}" | tee -a /root/nessusinstall.log
	else
		echo -e "${RED}Failed to start Nessus service${NC}" | tee -a /root/nessusinstall.log
		exit 1
	fi
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

# Install custom cert for web portal
CERT=/opt/certificates/$(hostname).crt
	if test -f "$CERT"; then
		echo -e "${GRN}$CERT exists, installing...${NC}" | tee -a /root/nessusinstall.log
		systemctl stop nessusd | tee -a /root/nessusinstall.log
		mv /opt/nessus/com/nessus/CA/servercert.pem /opt/nessus/com/nessus/CA/servercert.pem.bak &>> /root/nessusinstall.log
		mv /opt/nessus/var/nessus/CA/serverkey.pem /opt/nessus/var/nessus/CA/serverkey.pem.bak &>> /root/nessusinstall.log
		cp /opt/certificates/$(hostname).crt /opt/nessus/com/nessus/CA/servercert.pem && chmod 644 /opt/nessus/com/nessus/CA/servercert.pem &>> /root/nessusinstall.log
		cp /opt/certificates/$(hostname).key /opt/nessus/var/nessus/CA/serverkey.pem && chmod 600 /opt/nessus/com/nessus/CA/servercert.pem &>> /root/nessusinstall.log
		systemctl restart nessusd | tee -a /root/nessusinstall.log
	else
		echo -e "${ORN}No local certifcate was detected, please install manually${NC}" | tee -a /root/nessusinstall.log
	fi
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

echo -e "${GRN}Nessus installed${NC} - Please connect to ${CYN}https://$(hostname -f):8834${NC}" | tee -a /root/nessusinstall.log
##################################################################################################################################

EOF

chmod 777 nessus-instal.sh
./nessus-install.sh

# GRAB USERNAME AND PASSWORD FROM OUTPUT (pg. 43) ***

# OPEN PORT
open port 8834 – tcp in security group 

# CREATE USER ACCOUNT
useradd SVC_NessusScan
passwrd SVC_NessusScan
usermod -aG wheel SVC_NessusScan

# ADD NEW USER TO (pg. 45)

AFTER_REBOOT
