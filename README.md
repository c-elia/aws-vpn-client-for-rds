
# AWS VPN Client for RDS

This repository provides a configuration for setting up an AWS Client VPN to securely access a private RDS instance using Terraform and Easy-RSA.

## Prerequisites

1. **AWS Client VPN Desktop Application**  
   Download and install the [AWS Client VPN Desktop application](https://aws.amazon.com/vpn/client-vpn-download/) on your machine.

2. **Terraform**  
   Ensure you have Terraform installed. You can download it from [terraform.io](https://www.terraform.io/downloads).

## Setup Instructions

### 1. Initialize and Apply Terraform Configuration

First, set up your Terraform environment:

```bash
terraform init
terraform plan
terraform apply
```

To destroy the infrastructure when no longer needed, run:

```bash
terraform destroy
```

### 2. Generate VPN Certificates with Easy-RSA

#### Install Easy-RSA

Clone the Easy-RSA repository and navigate to the directory:

```bash
git clone https://github.com/OpenVPN/easy-rsa.git
cd easy-rsa/easyrsa3
```

Initialize the Public Key Infrastructure (PKI) and build the necessary certificates:

```bash
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa --san=DNS:server build-server-full server nopass
./easyrsa build-client-full client1.domain.tld nopass
```

Create a directory to store your certificates and copy the generated files:

```bash
mkdir ~/vpn_certs/
cp pki/ca.crt ~/vpn_certs/
cp pki/issued/server.crt ~/vpn_certs/
cp pki/private/server.key ~/vpn_certs/
cp pki/issued/client1.domain.tld.crt ~/vpn_certs/
cp pki/private/client1.domain.tld.key ~/vpn_certs/
```

Navigate to your certificate directory:

```bash
cd ~/vpn_certs/
```

### 3. Configure the Client VPN

After applying the Terraform configuration, export the client VPN configuration:

```bash
aws ec2 export-client-vpn-client-configuration \
--client-vpn-endpoint-id "cvpn-endpoint-xxxxxxxxxxxxxxxxxx" \
--output text > rdsclientconfig.ovpn
```

Edit the `rdsclientconfig.ovpn` file to include the client certificate and key paths. Add the following lines at the end of the file:

```
cert /path/client1.domain.tld.crt
key /path/client1.domain.tld.key
```

Replace `/path/` with the actual path to your certificate and key files.

## Additional Resources

- [AWS Client VPN Documentation](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/what-is-client-vpn.html)
- [Easy-RSA Documentation](https://github.com/OpenVPN/easy-rsa)

For more details on how to use and configure AWS Client VPN, refer to the official [AWS documentation](https://aws.amazon.com/documentation/vpn/).
