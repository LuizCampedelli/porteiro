INSTANCE_ID_PORTEIRO=i-03c101d76e63c6f93
IP_PORTEIRO=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID_PORTEIRO
--query "Reservations[].Instances[].PublicIpAddress" --profile cliente-porteiro
--region us-east-1 --output json | grep -vE '\[|\]' | awk -F'"' '{ print $2 }')
echo $IP_PORTEIRO

PEM_PATH="~/Downloads/SAM/porteiro/key-porteiro-2024.pem"
SERVIDOR_RDS_1=wordpress.clyess08onm7.us-east-1.rds.amazonaws.com
PORTA_LOCAL_RDS_1=3307
# SERVIDOR_RDS_2=SEU_SERVIDOR_2
# PORTA_LOCAL_RDS_2=5433
ssh -f -N -i $PEM_PATH ec2-user@$IP_PORTEIRO -L $PORTA_LOCAL_RDS_1:$SERVIDOR_RDS_1:3306

echo "Porteiro liberou acesso para:"
echo "> $SERVIDOR_RDS_1 no endereço *127.0.0.1:$PORTA_LOCAL_RDS_1"
