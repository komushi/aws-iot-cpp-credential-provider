#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

THING_NAME=$1

IAM_ROLE="iot-credential-provider-role"
IAM_POLICY="accesspolicyforfirehose"
ROLE_ALIAS="firehose-access-role-alias"
IOT_POLICY="RequestCertificatePolicy"
CERTIFICATE_PEM_OUTFILE="./cert/certificate.pem.crt"
PUBLIC_KEY_OUTFILE="./cert/public.pem.key"
PRIVATE_KEY_OUTFILE="./cert/private.pem.key"
ROLE_POLICY_DOCUMENT="file://./config/trustpolicyforiot.json"
IAM_POLICY_DOCUMENT="file://./config/firehosepolicy.json"
IOT_POLICY_DOCUMENT="file://./config/thingpolicy.json"

# generate role and policy just for once
IAM_ROLE_ARN=$(aws iam create-role --role-name $IAM_ROLE --assume-role-policy-document $ROLE_POLICY_DOCUMENT | jq -r '.Role.Arn')
IAM_POLICY_ARN=$(aws iam create-policy --policy-name $IAM_POLICY --policy-document $IAM_POLICY_DOCUMENT | jq -r '.Policy.Arn')
aws iam attach-role-policy --role-name $IAM_ROLE --policy-arn $IAM_POLICY_ARN
aws iot create-role-alias --role-alias $ROLE_ALIAS --role-arn $IAM_ROLE_ARN --credential-duration-seconds 3600
aws iot create-policy --policy-name $IOT_POLICY --policy-document $IOT_POLICY_DOCUMENT

# generate cert and thing
aws iot create-thing --thing-name $THING_NAME
CERT_ARN=$(aws iot create-keys-and-certificate --set-as-active --certificate-pem-outfile $CERTIFICATE_PEM_OUTFILE --public-key-outfile $PUBLIC_KEY_OUTFILE --private-key-outfile $PRIVATE_KEY_OUTFILE | jq -r '.certificateArn')
aws iot attach-thing-principal --thing-name $THING_NAME --principal $CERT_ARN
aws iot attach-policy --policy-name $IOT_POLICY --target $CERT_ARN

