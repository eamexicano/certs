#!/bin/bash

# Especificar dónde está OPENSSL en el sistema
# La ruta se puede obtener con 
# $ which openssl

OPENSSL="/usr/bin/openssl"


# Nombre para los certificados que se van a generar 
archivo="server"

# Valores que se le van a asignar a la petición de certificados CSR.
# . significa valor no asignado.

# C = Country Name (2 letter code) [AU]
# ST = State or Province Name (full name) [Some-State]
# ASDD = Locality Name (eg, city) []
# O = Organization Name (eg, company) [Internet Widgits Pty Ltd]
# OU = Organizational Unit Name (eg, section) []
# CN = Common Name (e.g. server FQDN or YOUR name) []
# emailAddress = Email Address []

C="CN"
ST="SN"
ASDD="Locality Name"
O="Organization Name"
OU="Organizational Unit Name"
CN="Common Name"
emailAddress="."

subject="/C=$C/ST=$ST/L=$ASDD/O=$O/OU=$OU/CN=$CN/emailAddress=$emailAddress"

echo "Generando ${archivo}.key"
OPENSSL genrsa -out ${archivo}.key 1024

echo "Generando ${archivo}.csr"
OPENSSL req -subj "$subject" -new -key ${archivo}.key -out ${archivo}.csr

echo "Generando ${archivo}.crt"
OPENSSL x509 -req -days 365 -in ${archivo}.csr -signkey ${archivo}.key -out ${archivo}.crt

echo "Generando ${archivo}.pem"
OPENSSL x509 -inform DER -outform PEM -in ${archivo}.csr -out ${archivo}.pem

if [ "$?" -ne "0" ]; then
  echo "No se pudo generar el archivo pem."
  echo "Revisa los errores arrojados. ¿son similares a estos?"
  echo "0D0680A8:asn1 encoding routines:ASN1_CHECK_TLEN:wrong tag"
  echo "0D07803A:asn1 encoding routines:ASN1_ITEM_EX_D2I:nested asn1 error"
  echo "S(i)/N(o)"
  read copia
  if [[ $copia =~ ^[sS]*$ ]]; then
    echo "Se crea una copia de ${archivo}.crt como ${archivo}.pem"
    cp ${archivo}.crt ${archivo}.pem
    echo "Archivos generados: ${archivo}.key ${archivo}.csr ${archivo}.crt ${archivo}.pem"    
  else
    echo "Archivos generados: ${archivo}.key ${archivo}.csr ${archivo}.crt"
  fi
  exit 1
fi

echo "Archivos generados: ${archivo}.key ${archivo}.csr ${archivo}.crt ${archivo}.pem"    
exit 0