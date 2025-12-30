pipeline {
    agent any

    tools {
        terraform 'terraform'
    }

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
                sh 'terraform version'
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -var-file=terraform.tfvars -out=tfplan.txt'
            }
        }

        stage('Approval') {
            when {
                expression { !params.autoApprove }
            }
            steps {
                script {
                    input message: 'Do you want to apply the Terraform plan?'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan.txt'
            }
        }
    }
}
