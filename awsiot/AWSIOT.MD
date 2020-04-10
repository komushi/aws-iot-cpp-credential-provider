# 0. Use Command Line Mode at awsiot/
```
$ chmod +x create_cert.sh
$ chmod +x clean_up.sh
```

# 1. Setup Option 1: Script
```
$ source ./create_cert.sh <thing_name>
```

```
$ ./clean_up.sh
```

# 2. Setup Option 2: Step-by-Step
## 2-1. Create IAM Role, Policy
*Only do this for once*
```
$ eval "$(aws iam create-role --role-name iot-credential-provider-role --assume-role-policy-document file://./config/trustpolicyforiot.json | jq -r '@sh "export IAM_ROLE_ARN=\(.Role.Arn)"')"
```

```
$ eval "$(aws iam create-policy --policy-name accesspolicyforfirehose --policy-document file://./config/firehosepolicy.json | jq -r '@sh "export IAM_POLICY_ARN=\(.Policy.Arn)"')"
```

```
$ aws iam attach-role-policy --role-name iot-credential-provider-role --policy-arn $IAM_POLICY_ARN
```

## 2-2. Create IoT RoleAlias & Policy
*Only do this for once*
```
$ aws iot create-role-alias --role-alias firehose-access-role-alias --role-arn $IAM_ROLE_ARN --credential-duration-seconds 3600
```

```
$ aws iot create-policy --policy-name RequestCertificatePolicy --policy-document file://./config/thingpolicy.json
```

## 2-3. Create Thing & Certificate; Attach IoT Policy
*Execute this when a new thing and a new certificate is needed.*
```
$ export THING_NAME=thing001
$ export IOT_POLICY="RequestCertificatePolicy"
$ export CERTIFICATE_PEM_OUTFILE="./cert/certificate.pem.crt"
$ export PUBLIC_KEY_OUTFILE="./cert/public.pem.key"
$ export PRIVATE_KEY_OUTFILE="./cert/private.pem.key"
$ export ROLE_ALIAS="firehose-access-role-alias"
$ export IAM_ROLE="iot-credential-provider-role"
$ export IAM_POLICY="accesspolicyforfirehose"
```

```
$ aws iot create-thing --thing-name $THING_NAME
```

```
$ eval "$(aws iot create-keys-and-certificate --set-as-active --certificate-pem-outfile ./cert/certificate.pem.crt --public-key-outfile ./cert/public.pem.key --private-key-outfile ./cert/private.pem.key | jq -r '@sh "export CERT_ARN=\(.certificateArn)"')"
```

```
$ aws iot attach-thing-principal --thing-name $THING_NAME --principal $CERT_ARN
```

```
$ aws iot attach-policy --policy-name RequestCertificatePolicy --target $CERT_ARN
```
