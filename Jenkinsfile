pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '3', artifactNumToKeepStr: '3'))
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('terraform-aws-tcs-jenkins')
        AWS_SECRET_ACCESS_KEY = credentials('terraform-aws-tcs-jenkins')
    }

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Auto approve Terraform apply')
    }

    stages {

        stage('Terraform Version') {
            steps {
                echo 'Checking Terraform version'
                sh 'terraform version'
            }
        }

        stage('Terraform Format') {
            steps {
                echo 'Formatting Terraform code'
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Init') {
            steps {
                echo 'Terraform Initialization in progress'
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo 'Terraform Planning in progress'
                sh 'terraform plan -var-file=terraform.tfvars -out=tfplan.txt'
            }
        }

        stage('Approval') {
            when {
                expression { !params.autoApprove }
            }
            steps {
                script {
                    def plan = readFile('tfplan.txt')
                    input message: 'Do you want to apply the Terraform plan?',
                          parameters: [
                              text(
                                  name: 'Terraform Plan',
                                  description: 'Review the plan below',
                                  defaultValue: plan
                              )
                          ]
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                echo 'Applying Terraform changes'
                sh 'terraform apply -auto-approve tfplan.txt'
            }
        }
    }
}
