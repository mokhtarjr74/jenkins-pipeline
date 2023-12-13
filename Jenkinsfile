pipeline {
    agent {label 'clone-agent'}
    tools {
        maven 'MAVEN3'
        jdk 'java17
    }
    stages {
        stage('CI') {
            steps {
                git branch: 'main', url: 'https://github.com/mokhtarjr74/jenkins-pipeline.git'
            }
            post {
                success {
                    echo 'CI success'
            }
                failure {
                    echo 'CI failed'
            }
        }
        }
       
    }
}