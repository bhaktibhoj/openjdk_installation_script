sudo apt update -y

sudo apt install openjdk-8-jdk -y

JDK_LOCATION=/usr/lib/jvm/java-8-openjdk-amd64

echo -n "Updating /etc/profile ... "

echo JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
#PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
#export JAVA_HOME

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

echo $JAVA_HOME

java --version


