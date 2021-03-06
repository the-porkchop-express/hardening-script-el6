#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on
# 08-jan-2012 to output an error in the standard error file if a hash
# is found in /etc/gshadow.



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22347
#Group Title: GEN001470
#Rule ID: SV-26467r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001470
#Rule Title: The /etc/gshadow file must not contain password hashes.
#
#Vulnerability Discussion: If password hashes are readable by non-administrators, the passwords are subject to attack through lookup tables or cryptographic weaknesses in the hashes.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that no password hashes are present in /etc/gshadow.
# cut -d : -f 2 /etc/gshadow | grep -v '^(x|\*)$'
#If any password hashes are returned, this is a finding.
#
#Fix Text: Migrate /etc/gshadow password hashes to /etc/gshadow.
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Checking LNX001476: Password Hashes in gshadow'
echo '==================================================='

#Global Variables#
PDI=LNX001476

#Start-Lockdown	

# Lets go ahead and make sure an error is reported just in case.
BADHASH=`awk -F ':' '{ if($2 != "x" && $2 != "*" && $2 != "!" && $2 != "!!" && $2 != "") print $1 }' /etc/gshadow | tr "\n" " "`  
if [ "$BADHASH" != "" ]; then
	echo "------------------------------"
	echo "$PDI: The following users have password hashes in the /etc/gshadow file."
	echo
	echo "${BADHASH}"
	echo
	echo "------------------------------"
fi
