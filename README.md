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

You can configure some params directly in the playbook [site.yaml](site.yaml):

* project_id: Google cloud profile id
* machine_type: Type of the instance (n1-standard-1)
* image: Image id, e.g. centos-7
* service_account_email: Google service account email, e.g. "74586816724-compute@developer.gserviceaccount.com"
* credentials_file: path to the google cloud credentials file, e.g. "{{ playbook_dir }}/credentials.json"
* zone: Zone where to start the instance, e.g. "us-central1-b"
* openvpn_config_file_path: Path where to copy the openvpn config file for later use, e.g. "/Users/mjoeh/vpn/myopen.ovpn"

#### Google credentials
You also need to provide a credentials_file.json in the root path of this project which you can
download from your google account and you need to set your gcloud profile id + service_account_email.

### Run
Just run ansible via the wrapper which will also install the needed python libs in an virtual environment.
```
./ansiblew localhost, site.yaml
```
