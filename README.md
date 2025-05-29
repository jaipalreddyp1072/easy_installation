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

# as a jenkins user
```
mkdir -p /var/lib/jenkins/.aws
mkdir -p /var/lib/jenkins/.kube
```
```
sudo chown -R jenkins:jenkins /var/lib/jenkins/.aws /var/lib/jenkins/.kube
```
# as a jenkins user
```
aws eks update-kubeconfig --name cluster-name --region us-east-1
```
