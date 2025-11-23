pipeline {
    agent any

    tools {
        maven 'mymaven'
        jdk 'JDK21'
    }

    environment {
        SONAR_TOKEN = credentials('SONAR_TOKEN') // ID du token ajouté dans Jenkins
    }

    stages {
        stage('Checkout code') {
            steps {
                git branch: 'main', url: 'https://github.com/NadhemBenhadjali/Pipeline-CI'
            }
        }

        stage('Build & Tests (Maven)') {
            steps {
                sh 'mvn clean verify'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('MySonar') {   // nom du serveur dans Jenkins
                    sh """
                        mvn sonar:sonar \
                          -Dsonar.projectKey=country-service \
                          -Dsonar.projectName=country-service \
                          -Dsonar.host.url=${SONAR_HOST_URL} \
                          -Dsonar.login=${SONAR_TOKEN}
                    """
                }
            }
        }

        stage('Deploy using Ansible playbook') {
            steps {
                script {
                    sh 'ansible-playbook -i localhost, playbookCICD.yml'
                }
            }
        }
        stage('Deploy Monitoring (Prometheus & Grafana)') {
            steps {
                sh 'ansible-playbook -i localhost, monitoring/monitoring-playbook.yml'
        }
}

    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline exécuté avec succès !'
        }
        failure {
            echo 'L\'exécution du pipeline a échoué !'
        }
    }
}


