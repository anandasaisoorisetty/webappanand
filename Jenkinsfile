pipeline {
    agent any

    stages {
        stage('SCM Checkout') {
            steps {
                git url: 'https://github.com/anandasaisoorisetty/webappanand.git', branch: 'main'
            }
        }

        stage('NPM Build') {
            steps {
                // Install Node.js and npm
                tool 'NodeJS'
                sh 'npm install'

                // Build Angular app
                sh 'npm run build'
            }
        }

        // Add additional stages as needed (e.g., test, deploy, etc.)
    }

}
