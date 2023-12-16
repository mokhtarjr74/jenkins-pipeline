pipeline {
    agent {label 'clone-agent'}
    tools {
        maven 'MAVEN3'
        jdk 'java17'
    }
    environment {
        DOCKER_CREDENTIALS = credentials('docker-token')
        DOCKER_IMAGE_NAME = 'demo-jenkins-maven'
        Docker_IMAGE_TAG = "V1-${BUILD_NUMBER}"
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
        stage('SonarQube Quality Gate Check') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonarqube-token') {
                        def qualityGate = waitForQualityGate()
                        if (qualityGate.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qualityGate.status}"
                        }
                    }
                }
            }
        }
        stage('build docker image') {
            steps {
                script {
            sh "docker build -t ${DOCKER_CREDENTIALS_USR}/${DOCKER_IMAGE_NAME}:${Docker_IMAGE_TAG} ."
            sh "docker login -u $DOCKER_CREDENTIALS_USR -p $DOCKER_CREDENTIALS_PSW"
            sh "docker push ${DOCKER_CREDENTIALS_USR}/${DOCKER_IMAGE_NAME}:${Docker_IMAGE_TAG}"
                }
            }
        }
             
    }
}