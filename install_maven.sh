#!/bin/bash

set -e

echo "Updating package lists..."
apt update

echo "Installing OpenJDK 21..."
apt install -y openjdk-21-jdk

echo "Verifying Java installation..."
java -version
javac -version

echo "Installing Maven..."
apt install -y maven

echo "Verifying Maven installation..."
mvn -version
echo "Installation of OpenJDK 21 and Maven is complete!"

