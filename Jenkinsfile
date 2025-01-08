pipeline {
    agent any

    environment {
        TF_WORKING_DIR = 'terraform' // Caminho para o diretório Terraform no repositório
    }

       stages {
        stage('Terraform Init') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    dir('terraform') {
                        sh '''
                        terraform init
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    dir('terraform') {
                        sh '''
                        terraform plan
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    dir('terraform') {
                        sh '''
                        terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline executada com sucesso!'
        }
        failure {
            echo 'Erro na pipeline!'
        }
    }
}
