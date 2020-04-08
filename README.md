# openjdk_installation_script
# Ubuntu Java Installer
Bash script that automates installation of Open source Java (JDK) on Ubuntu Linux.

## Usage
```
Help page


Usage:   openjava8.sh [options]

Example: openjava8.sh remove-openjdk

Available options are:
  remove-openjdk
      Removes (purges) OpenJDK from the system. Using this option
      ensures that OpenJDK is not present in the system, therefore
      no application will use it instead of Oracle JDK.

  install-openjdk
      Install the OpenJDK to the system.
  --help
      Displays this help message.
```

***NOTE***

Before running the script make sure it has permissions to execute and you run it with root permissions.

Set execution permissions with ```chmod +x openjava8.sh```
and execute it with root permissions with ```sudo ./openjava8.sh```
