pipeline {
    agent any
    def buildNumber = BUILD_NUMBER
    stages {
        stage('SCM CheckOut') {
            steps {
                git url: 'https://github.com/anandasaisoorisetty/webappanand.git',branch: 'main'
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
