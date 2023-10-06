# This is a simple application written in FastApi which will tell you your soul animal
I want to deploy the application so a lot of people can see their soul animals. I will deploy this to aws but I do not want to log in into aws console again and again.
## Tech Stack
- FastApi as backend 
- Postgres as database
- Terraform for infrastructure provisioning and management

## Plans
- [x] Create a simple application
    - [x] Deploy the application to AWS EC2 , application, database all in same instance
    - [x] Deploy the application to AWS EC2, db in AWS RDS
    - [ ] Add ELB to the application
- [ ] Deploy the application in AWS ECS and AWS RDS
- [ ] Break the application and deploy as serverless
  - [ ] break the application into frontend and backend
  - [ ] deploy the frontend to aws s3
  - [ ] break the backend into lambda functions and deploy it in AWS Lambda
  - [ ] Use AWS Api Gateway for connecting the lambda function to frontend





## Resources
- [rds and ec2](https://medium.com/strategio/using-terraform-to-create-aws-vpc-ec2-and-rds-instances-c7f3aa416133)