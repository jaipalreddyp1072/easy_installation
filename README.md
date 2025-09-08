to install respectiv file from this repository

AWSCLI
```
curl -O https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_awscli.shsh
wget https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_awscli.sh
```
EKSCTL
```
curl -O https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_eksctl.sh
wget https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_eksctl.sh
```
HELM
```
curl -O https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_helm.sh
wget https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_helm.sh
```
JENKINS
```
curl -O https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_jenkins.sh
wget https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_jenkins.sh
```
KUBECTL
```
curl -O https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_kubectl.sh
wget https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_kubectl.sh
```
MAVEN
```
curl -O https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_maven.sh
wget https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_maven.sh
```
PRITUNL
```
curl -O https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_pritunl.sh
wget https://raw.githubusercontent.com/jpl-ry/to_run_and-_install_tools/master/install_pritunl.sh
```
# After copying the git repository
```
cd to_run_and-_install_tools
```
# And after that
```
chmod +x *.sh
```
# to add docker to jenkins
```
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```
# Permissions for jenkins
 ```
sudo su - 
which kubectl
 ```
#As root: Move kubectl to global path
 ```
sudo cp /root/bin/kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl
```
As root: Configure kubeconfig with AWS CLI
This assumes aws configure has been run and aws/kubectl are installed.
```
aws eks update-kubeconfig --name cluster-name --region us-east-1
```
# Switch to jenkins user and create AWS/kube directories
 ```
sudo su - jenkins
```
```
mkdir -p /var/lib/jenkins/.aws
mkdir -p /var/lib/jenkins/.kube
```
```
exit
```
# As root: Copy AWS and kube config to Jenkins
```
sudo cp -r /root/.aws/* /var/lib/jenkins/.aws/
sudo cp -r /root/.kube/* /var/lib/jenkins/.kube/
```
```
sudo chown -R jenkins:jenkins /var/lib/jenkins/.aws /var/lib/jenkins/.kube
```
# as a jenkins user
 ```
sudo su - jenkins
```
```
aws eks update-kubeconfig --name cluster-name --region us-east-1
```
