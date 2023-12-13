pipeline {
    agent {label 'clone-agent'}
    tools {
        maven 'MAVEN3'
        jdk 'java17'
    }
    stages {
        stage("Cleanup Workspace"){
            steps {
                cleanWs()
            }

        }
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mokhtarjr74/jenkins-pipeline.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('sonarqube analysis') {
            steps {
                script{
                    withSonarQubeEnv(credentialsId: 'sonarqube-token'){
                    sh 'mvn sonar:sonar'
                }
                }
            }
        }
    }
}