pipeline {
    agent any

 environment {
        NVM_DIR = '/var/lib/jenkins/.nvm'
 }
    
    stages {
        stage('SCM Checkout') {
            steps {
                git url: 'https://github.com/anandasaisoorisetty/webappanand.git', branch: 'main'
            }
        }

        stage('NodeJS Setup') {
           steps {
                // Install nvm and set up Node.js
                script {
                    def nodeVersion = '14.20.0' // Adjust to the desired Node.js version

                    sh 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash'
                    sh "[ -s \"$NVM_DIR/nvm.sh\" ] && source \"$NVM_DIR/nvm.sh\" && nvm install $nodeVersion"
                    sh "[ -s \"$NVM_DIR/nvm.sh\" ] && source \"$NVM_DIR/nvm.sh\" && nvm use $nodeVersion"
                }
           }
        }

        stage('Build') {
            steps {
                // Install project dependencies
                sh 'npm install'

                // Build Angular app
                sh 'npm run build'
            }
        }
    }
}
