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

#echo $JAVA_HOME



# Verify and exit installation
echo -n "Verifying Java installation... "
JAVA_CHECK=`java -version 2>&1`
if [[ "$JAVA_CHECK" == *"OpenJDK Runtime Environment"* ]]; then
   echo "OK"
   echo
   echo "Java is successfully installed!"
   echo
   java -version
   echo $JAVA_HOME
   echo
   exit 0
else
   echo "FAILED"
   echo
   echo "Java installation failed!"
   echo
   exit 1
fi


