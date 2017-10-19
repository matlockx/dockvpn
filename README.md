# OpenVPN for Docker

This one is taken from jpetazzo/dockvpn but using an alpine image. It also comes with a playbook for
ansible which

* starts an instance in gcloud (centos 7)
* installs docker and updates all packages
* creates firewall rules
* starts the vpn server as a docker container
* downloads config
* kills the container which serves the config
* removes port 8080 again from firewall rule

### Configuration

You can configure some basics regarding the instance that will be started in gloud directly in the playbook [site.yaml]. You also need to provide a credentials_file.json in the root path of this project which you can
download from your google account and you need to set your gcloud profile id + service_account_email.

### Run
Just run ansible via the wrapper which will also install the needed python libs in an virtual environment.
```
./ansiblew localhost, site.yaml
```
