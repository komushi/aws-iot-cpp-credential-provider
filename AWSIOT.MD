
## 1. Create Thing and Certificate
```
aws iot create-thing --thing-name "thing002"
```

```
aws iot create-keys-and-certificate --set-as-active --certificate-pem-outfile ./cert/certificate.pem.crt --public-key-outfile ./cert/public.pem.key --private-key-outfile ./cert/private.pem.key
```

```
aws iot attach-thing-principal --thing-name "thing002" --principal "arn:aws:iot:<aws_region>:<aws_account>:cert/432cd9eea97d095ec9627ac6c7af8962d823813ba2e8742a6049c0f7f13acffb"
```

## 2. Create IAM Role, Policy and IoT RoleAlias
```
aws iam create-role --role-name iot-credential-provider-role --assume-role-policy-document file://./asset/trustpolicyforiot.json
```

```
aws iam create-policy --policy-name accesspolicyforfirehose --policy-document file://./asset/firehosepolicy.json
```

```
aws iam attach-role-policy --role-name iot-credential-provider-role --policy-arn "arn:aws:iam::<aws_account>:policy/accesspolicyforfirehose"
```

```
aws iot create-role-alias --role-alias firehose-access-role-alias --role-arn "arn:aws:iam::<aws_account>:role/iot-credential-provider-role" --credential-duration-seconds 3600
```

## 3. Create and Attach IoT Policy

```
aws iot create-policy --policy-name RequestCertificatePolicy --policy-document file://./asset/thingpolicy.json
```

```
aws iot attach-policy --policy-name RequestCertificatePolicy --target "arn:aws:iot:<aws_region>:<aws_account>:cert/432cd9eea97d095ec9627ac6c7af8962d823813ba2e8742a6049c0f7f13acffb"
```