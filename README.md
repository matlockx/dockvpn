# OpenVPN for Docker

This one is taken from jpetazzo/dockvpn but using an alpine image. It also comes with a playbook for
ansible which

* starts an instance in gcloud (centos 7)
* installs docker and updates all packages
* creates firewall rules
* starts the vpn server as a docker container
* downloads config
* kills the container which serves the config
* sends a mail with the config file to a given mail address
* removes port 8080 again from firewall rule

### Configuration

You can configure some params directly in the playbook [site.yaml](site.yaml):

#### Public

* machine_type: Type of the instance (n1-standard-1) -> https://cloud.google.com/compute/docs/machine-types
* image: Image id, e.g. centos-7 -> https://cloud.google.com/compute/docs/images
* credentials_file: path to the google cloud credentials file, e.g. "{{ playbook_dir }}/credentials.json" -> https://console.cloud.google.com/iam-admin/serviceaccounts/project create key, use json and download the file
* zone: Zone where to start the instance, e.g. "us-central1-b"
* openvpn_config_file_path: Path where to copy the openvpn config file for later use, e.g. "/Users/mjoeh
* mail_server: mail server
* mail_port: mail port

#### Private
There is some private data needed that should be located in a file called secrets.yaml
You can copy the content of the secrets_example.yaml into an ansible vault file and check it into your own repo. Variables are:

* project_id: Google cloud profile id -> https://console.cloud.google.com/iam-admin/settings/project
* service_account_email: Google service account email -> https://console.cloud.google.com/iam-admin/serviceaccounts/project
* openvpn_config_file_path: Path where to copy the openvpn config file for later use, e.g. "/Users/mjoeh/vpn/myopen.ovpn"
* mail_user: username
* mail_password: password for mail account
* mail_address: address from and where to send

### Run
Just run ansible via the wrapper which will also install the needed python libs in an virtual environment.
```
./ansiblew localhost, site.yaml --ask-vault-pass
```

Or with a local vault password file:

```
./ansiblew localhost, site.yaml --vault-password-file=vault_file
```

Afterwards you can connect via openvpn

```
sudo openvpn --config myopen.ovpn
```

#### Recreate machine_type

By adding the variable new_machine=true the running machine will be terminated and a new one will be started. You should get a new public IP afterwards.


```
./ansiblew localhost, site.yaml --vault-password-file=vault_file -e new_machine=true
```
