# OpenSSL-self_signature_SSL
Use open source tools (OpenSSL) to complete self-signed certificates for development/intranet environments

## SSL generate workflow
![image](https://github.com/as183789043/OpenSSL-self_signature_SSL/assets/56618553/5a4d4e47-adde-4c99-90b2-4c90fafad955)

## Prerequest (Demo by Ubuntu about example.conm and localhost)
- OpenSSL package
- Sudo permission

## Get Start
```bash
git clone https://github.com/as183789043/OpenSSL-self_signature_SSL.git
cd OpenSSL-self_signature_SSL
```

## Check ca.cnf parameter 
```bash
[ CA_default ]
dir               = /root/ca  ##Check you path to replcae it
default_days      = 3650 ##CA vaild retentation

[ req_distinguished_name ]  ##Default setting if you press enter 
countryName_default             = TW
stateOrProvinceName_default     = Taiwan
localityName_default            = Taipei
0.organizationName_default      = Example
organizationalUnitName_default  = IT
emailAddress_default            = test123@gmail.com
commonName_default              = Myca
```

## Check example.cnf parameter
```bash
[ req ]
days                   = 3650 #cert vaild retentation

[ req_distinguished_name ]  ##Replace to you environment setting
countryName            = TW
stateOrProvinceName    = Taiwan
localityName           = Taipei
organizationName       = Example
organizationalUnitName = IT
commonName             = example.com  ##Replace it to you domain(important!) 
emailAddress           = test123@myemail.com


[ sans ] # If you need another  domain vaild in this Cert
DNS.0 = example.com
DNS.1 = localhost
```

## Step by step to create vaild Ca and SSL-Certificate

1. create  CA private key (-deb3 parameter  will ask you about  text password )
   ```bash
   penssl genrsa -des3 -out <rootCA.key> 4096
   ```
2. create CA public Key (check parameter and press enter which setting is correct )
   ```bash
   openssl req -x509 -new -nodes -key <rootCA.key>  -out <rootCA.crt> -config <ca.cnf>
   ```
3. create private key
   ```bash
   openssl genrsa -out <example.key> 4096
   ```
4. Generate CSR
   ```bash
   openssl req -new -sha256 -nodes -key <example.key> -out <example.csr> -config  <example.cnf>
   ```
5. Sign Certifiacre by CSR and CA
   ```bash
   openssl x509 -req \
    -in <example.csr> \
    -CA <<rootCA.crt> \
    -CAkey <rootCA.key> \
    -CAcreateserial \
    -out <example.crt> \
    -days 3650 -sha512
   ```
6. Check File in your directory
   ```bash
   [root@rhel9 SSL]# ls
   example.cnf  example.key  rootCA.crt  rootCA.key  website.csr  website.key
   ```

## Check Certificate online (When using this key in a production environment, refrain from uploading any files to the websitee )
[Check link](https://www.cloudmax.com.tw/service/ssl-tools)

Check CSR
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/edbd24d8-8650-443c-af9c-e5f00f2a4492/31af6c85-e1c6-4996-89b0-b5da1ad0e419/Untitled.png)

Check Crt
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/edbd24d8-8650-443c-af9c-e5f00f2a4492/bb14dc3b-3330-44a3-b8ce-167c4e74dfff/Untitled.png)
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/edbd24d8-8650-443c-af9c-e5f00f2a4492/6a03f106-5910-442b-a841-c7f2892612fe/Untitled.png)

Check Crt and Key match
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/edbd24d8-8650-443c-af9c-e5f00f2a4492/f09da5c6-6a33-4608-9838-bdc6cce3f7ae/Untitled.png)

