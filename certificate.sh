if  [ $(find . -name "*.cnf" | wc -l) != 2 ]; then
        echo "Check you must have 2 cnf file in this directory"
        exit 0
fi

openssl genrsa -des3 -out rootCA.key 4096

openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 36500 -out rootCA.crt -config ca.cnf

openssl genrsa -out example.key 4096

openssl req -new -sha256 -nodes -key example.key -out example.csr -config  example.cnf

#openssl x509 -req -in example.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out example.crt -days 3650 -sha512
openssl x509 -req -in example.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out example.crt -days 3650 -sha512 -extfile example.cnf -extensions v3_req

echo "Generated Certificate Done!"
