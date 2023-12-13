Pipeline {
    agent any
    tools {
        go 'go-1.17'
    }

    environment{
        GO111MODULE = 'on'
    }

    stages{
        stage('test') {
            steps {
                git 'https://github.com/AdminTurnedDevOps/go-webapp-sample.git'
                sh 'go test ./...'
            }
        }
    }
}