pipeline {
    agent any

env.PATH = "/usr/local/bin:${env.PATH}"

    
    stages {
        stage('SCM Checkout') {
            steps {
                git url: 'https://github.com/anandasaisoorisetty/webappanand.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                // Install Node.js and npm
                tool 'NodeJS'
                sh 'npm install'

                // Build Angular app
                sh 'npm run build'
            }
        }
    }
}
