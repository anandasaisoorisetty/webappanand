# Define variables
$SERVICE_NAME = "demo"
$CLUSTER_NAME = "demo"
$AWS_REGION = "us-east-1"
$TASK_FAMILY = "demo-new"
$ROLE_ARN = "arn:aws:iam::730335223740:role/ecsTaskExecutionRole"

# Retrieve default subnets
$defaultSubnets = aws ec2 describe-subnets --filters "Name=default-for-az,Values=true" --query "Subnets[*].SubnetId" --output text --region $AWS_REGION
$subnetIdArray = $defaultSubnets -split "\t"

# Retrieve default security group
$defaultSecurityGroup = aws ec2 describe-security-groups --filters "Name=group-name,Values=default" --query "SecurityGroups[*].GroupId" --output text --region $AWS_REGION

# Create a new ECS cluster
Write-Output "Creating ECS cluster: $CLUSTER_NAME"
aws ecs create-cluster --cluster-name $CLUSTER_NAME --region $AWS_REGION

# Register a new Task definition
Write-Output "Registering new Task definition: $TASK_FAMILY"
aws ecs register-task-definition --family $TASK_FAMILY --cli-input-json file://task-new.json --region $AWS_REGION

# Create a new ECS service using Fargate
Write-Output "Creating ECS service: $SERVICE_NAME in cluster: $CLUSTER_NAME"
aws ecs create-service --cluster $CLUSTER_NAME --service-name $SERVICE_NAME --task-definition $TASK_FAMILY `
    --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[$($subnetIdArray -join ',')],securityGroups=[$defaultSecurityGroup],assignPublicIp=ENABLED}" --region $AWS_REGION

# Update the ECS service with the new task definition
Write-Output "Updating ECS service: $SERVICE_NAME with new task definition: $TASK_FAMILY"
aws ecs update-service --cluster $CLUSTER_NAME --service $SERVICE_NAME --task-definition $TASK_FAMILY --desired-count 1 --region $AWS_REGION

Write-Output "ECS setup completed."
