parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

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
CERT_ID=$(echo $CERT_ARN | cut -d'/' -f 2)

aws iot detach-policy --policy-name $IOT_POLICY --target $CERT_ARN
aws iot detach-thing-principal --thing-name $THING_NAME --principal $CERT_ARN
aws iot delete-thing --thing-name $THING_NAME
aws iot update-certificate --certificate-id $CERT_ID --new-status "INACTIVE"
aws iot delete-certificate --certificate-id $CERT_ID
aws iot delete-policy --policy-name $IOT_POLICY
aws iot delete-role-alias --role-alias $ROLE_ALIAS
aws iam detach-role-policy --role-name $IAM_ROLE --policy-arn $IAM_POLICY_ARN
aws iam delete-policy --policy-arn $IAM_POLICY_ARN
aws iam delete-role --role-name $IAM_ROLE
