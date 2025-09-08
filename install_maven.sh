#!/bin/bash
set -e

# Install JDK 21
JAVA_VERSION=21
JAVA_DIR=$HOME/java
mkdir -p $JAVA_DIR

echo "Downloading OpenJDK $JAVA_VERSION..."
curl -L https://download.java.net/java/GA/jdk${JAVA_VERSION}/latest/binaries/openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz -o jdk.tar.gz
tar -xzf jdk.tar.gz -C $JAVA_DIR --strip-components=1

export PATH=$JAVA_DIR/bin:$PATH

echo "Java installed at $JAVA_DIR"
java -version
javac -version

# Install Maven
MAVEN_VERSION=3.9.9
MAVEN_DIR=$HOME/maven
mkdir -p $MAVEN_DIR

echo "Downloading Apache Maven $MAVEN_VERSION..."
curl -sL https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -o maven.tar.gz
tar -xzf maven.tar.gz -C $MAVEN_DIR --strip-components=1

export PATH=$MAVEN_DIR/bin:$PATH

echo "Maven installed at $MAVEN_DIR"
mvn -version

echo "✅ Installation of OpenJDK 21 and Maven is complete!"


