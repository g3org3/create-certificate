make: rootCA selfsign device device-cert sign-device

rootCA:
	@echo Starting...
	#openssl genrsa -out rootCA.key 2048
	openssl genrsa -des3 -out rootCA.key 2048
	#openssl genrsa -sha256 -out rootCA.key 4096

selfsign:
	@echo Self signing
	openssl req -x509 -new -nodes -key rootCA.key -days 1024 -out rootCA.pem

device:
	@echo Generate device key...
	openssl genrsa -out device.key 2048

device-cert:
	@echo Generate device csr..
	openssl req -new -key device.key -out device.csr

sign-device:
	@echo Signing device certificate
	openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 500

ios:
	openssl x509 –inform PEM –outform DER –in rootCA.pem –out cert.der


