certs.sh
========

Script en bash para generar certificados key, csr, crt, pem con [OpenSSL](http://openssl.org/ "OpenSSL").


Uso
===

Ajustar la ubicación de OpenSSL en el sistema. 

Utiliza - /usr/bin/openssl

Definir el nombre de archivo para los certificados que se van a generar

Utiliza - "server"

Al momento de generar un CSR se solicitan los siguientes valores.

Actualizar los valores definidos en el script 

- Country Name (2 letter code) [AU]:
- State or Province Name (full name) [Some-State]:
- Locality Name (eg, city) []:
- Organization Name (eg, company) [Internet Widgits Pty Ltd]:
- Organizational Unit Name (eg, section) []:
- Common Name (e.g. server FQDN or YOUR name) []:
- emailAddress = Email Address []:

- C="CN"
- ST="SN"
- ASDD="Locality Name"
- O="Organization Name"
- OU="Organizational Unit Name"
- CN="Common Name"
- emailAddress="."


Una vez que se establezcan los valores, en la carpeta donde se quieren generar los certificados teclear:

$ ./certs.sh

Utiliza Licencia MIT