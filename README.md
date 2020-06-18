# terraform-msk-fargate #

### This terraform template creates:
- AWS FARGATE cluster
- Amazon MSK
- EC2
- Network (VPC, SUBNETS)

### Directory Structure:
```sh
.
├── README.md
├── main.tf
├── modules
│   ├── ec2
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── fargate
│   │   ├── ecs.json.tpl
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── msk
│   │   ├── main.tf
│   │   └── variables.tf
│   └── network
│       ├── main.tf
│       └── variables.tf
├── src
│   ├── consumer
│   │   ├── Dockerfile
│   │   ├── consumer.py
│   │   └── environment.yml
│   ├── creator
│   │   └── create_topic.py
│   └── scripts
│       ├── create_topic.sh
│       └── install_kafka.sh
└── variables.tf
```


### How do I get set up?

Dependencies:
- [Docker](https://docs.docker.com/get-docker/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [Terraform](https://www.terraform.io/downloads.html)


``` sh
IMAGE_NAME="kafka-consumer"
# Build the Docker image.
cd src/consumer
docker build -t $IMAGE_NAME .

# Authenticate Docker with ECR.
$(aws ecr get-login --region us-east-1 --no-include-email)

# Create a repo in ECR.
aws ecr create-repository --repository-name $IMAGE_NAME --region us-east-1

# Set ECR repository name
# ------------
# Use below instead if jq is available.
# ECR_REPO=$(aws ecr describe-repositories --repository-names $IMAGE_NAME | jq '.repositories[0].repositoryUri')
# -------------
ECR_REPO="<aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/${IMAGE_NAME}"

# Tag the docker image.
docker tag $IMAGE_NAME $ECR_REPO 

# Push the image.
docker push $ECR_REPO 

# Replace app_image in ./main.tf file with $ECR_REPO value.

# Create resources with Terraform.
terraform init
terraform plan
terraform apply
```
