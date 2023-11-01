#!/bin/bash

# Set your AWS region
AWS_REGION="us-east-1"

# Set the SNS topic name
SNS_TOPIC_NAME="trivyscan"

# Set the email addresses to subscribe
EMAIL_ADDRESS_1="asoorisetty@gmail.com"
EMAIL_ADDRESS_2="example1@example.com"
EMAIL_ADDRESS_3="example2@example.com"

# Create an SNS topic and capture the ARN
topic_arn=$(aws sns create-topic --name $SNS_TOPIC_NAME --region $AWS_REGION --output text)

# Subscribe email addresses to the SNS topic
aws sns subscribe --topic-arn $topic_arn --protocol email --notification-endpoint $EMAIL_ADDRESS_1 --region $AWS_REGION
aws sns subscribe --topic-arn $topic_arn --protocol email --notification-endpoint $EMAIL_ADDRESS_2 --region $AWS_REGION
aws sns subscribe --topic-arn $topic_arn --protocol email --notification-endpoint $EMAIL_ADDRESS_3 --region $AWS_REGION

# Wait for confirmation
echo "Please check your email to confirm the subscriptions."

# Publish a sample message to the SNS topic
aws sns publish --topic-arn $topic_arn --message "This is a sample message from the Trivy scanner." --subject "Sample Trivy Scan" --region $AWS_REGION

echo "Sample message published to the SNS topic."
