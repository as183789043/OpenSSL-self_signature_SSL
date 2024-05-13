# OpenSSL-self_signature_SSL
Use open source tools (OpenSSL) to complete self-signed certificates for development/intranet environments

## SSL generate workflow
![image](https://github.com/as183789043/OpenSSL-self_signature_SSL/assets/56618553/5a4d4e47-adde-4c99-90b2-4c90fafad955)

## Prerequest (Demo by Ubuntu about example.com and localhost)
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
    -CA <rootCA.crt> \
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

## If you want generate certificate by script (2024/05/13 update)
```
chmod +x certificate.sh
./certificate.sh  #Enter ca.key text password and decrypt it  to generate certificate
```

## Check Certificate online (When using this key in a production environment, refrain from uploading any files to the websitee )
[Online check link](https://www.cloudmax.com.tw/service/ssl-tools)

Check CSR
![csr](https://github.com/as183789043/OpenSSL-self_signature_SSL/assets/56618553/2ad7eae4-6f66-4352-83a7-4e244caf9d10)

Check Crt
![crt1](https://github.com/as183789043/OpenSSL-self_signature_SSL/assets/56618553/8b3ee977-fa6f-4fb5-8845-fa5da3994856)
![crt2](https://github.com/as183789043/OpenSSL-self_signature_SSL/assets/56618553/7adc9c5a-5943-49e5-afcf-a3a16e0d7d3d)

Check Crt and Key match
![match](https://github.com/as183789043/OpenSSL-self_signature_SSL/assets/56618553/460fff5a-4cc7-4baf-aa46-c8ce88f02e34)


