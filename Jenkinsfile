pipeline {
    agent any

    stages {
        stage('SCM Checkout') {
            steps {
                git url: 'https://github.com/anandasaisoorisetty/webappanand.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Set PATH environment variable
                    env.PATH = "/usr/local/bin:${env.PATH}"

                    // Install Node.js and npm
                    tool 'NodeJS'
                    sh 'npm install'

                    // Build Angular app
                    sh 'npm run build'
                }
            }
        }
    }
}