#!/bin/bash


# Functions
# Displays script usage
display_usage() {
   echo "Usage:   $0 [options]"
}

# Displays help (--help option)
display_help() {
   echo "Help page"
   echo
   echo
   display_usage
   echo
   echo "Example: $0 remove-openjdk"
   echo
   echo "Available options are:"
   echo "  remove-openjdk"
   echo "      Removes (purges) OpenJDK from the system. Using this option"
   echo "      ensures that OpenJDK is not present in the system, therefore"
   echo "      no application will use it instead of Oracle JDK."
   echo
   echo "  install-openjdk"
   echo "      Install the OpenJDK to the system."
   echo "  --help"
   echo "      Displays this help message."
   echo
}


# Start of the script
echo
echo Ubuntu Open Source Java Installer
echo


# Display usage information if no parameters were provided
if [ $# -eq 0 ]; then
   display_usage
   exit 1
fi

# Check if the script is running with root permissions
if [ `id -u` -ne 0 ]; then
   echo "The script must be run as root! (you can use sudo)"
   exit 1
fi

if [ "$1" = install-openjdk ]; then
{
sudo apt update -y

sudo apt install openjdk-8-jdk -y

JDK_LOCATION=/usr/lib/jvm/java-8-openjdk-amd64

echo -n "Updating /etc/profile ... "

echo JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

cat >> /etc/profile <<EOF
JAVA_HOME=$JDK_LOCATION
JRE_HOME=$JDK_LOCATION/jre
PATH=$PATH:$JDK_LOCATION/bin:$JDK_LOCATION/jre/bin
export JAVA_HOME
export JRE_HOME
export PATH
EOF

echo "OK"

source /etc/profile

# Update system to use Oracle Java by default

echo -n "Updating system alternatives... "
update-alternatives --install "/usr/bin/java" "java" "$JDK_LOCATION/jre/bin/java" 1 >> /dev/null
update-alternatives --install "/usr/bin/javac" "javac" "$JDK_LOCATION/bin/javac" 1 >> /dev/null
update-alternatives --install "/usr/bin/jar" "java" "$JDK_LOCATION/jre/bin/jar" 1 >> /dev/null
update-alternatives --set java $JDK_LOCATION/jre/bin/java >> /dev/null
update-alternatives --set javac $JDK_LOCATION/bin/javac >> /dev/null
update-alternatives --set jar $JDK_LOCATION/jre/bin/jar >> /dev/null
echo "OK"

# Verify and exit installation
echo -n "Verifying Java installation... "
JAVA_CHECK=`java -version 2>&1`
if [ "$JAVA_CHECK" == *"OpenJDK Runtime Environment"* ]; then
   echo "OK"
   echo
   echo "Java is successfully installed!"
   echo
   java -version
   echo
   exit 0
else
   echo "FAILED"
   echo
   echo "Java installation failed!"
   echo
   #exit 1
fi
}

elif [ "$1" = remove-openjdk ]; then
   echo "Purging OpenJDK... "
   apt-get purge -q openjdk-8\*
else 

    echo "specify option carefully!"
    display_usage
fi



