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
                // Install nvm
                sh 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash'
                sh 'export NVM_DIR="$HOME/.nvm"'
                 sh ' [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" '

                // Install required Node.js version
                sh 'nvm install 14.20.0' // Adjust to the desired Node.js version
                sh 'nvm use 14.20.0'
                
                // Install project dependencies
                sh 'npm install'

                // Build Angular app
                sh 'npm run build'
            }
        }

        // Add additional stages as needed (e.g., test, deploy, etc.)
    }

}
