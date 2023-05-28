pipeline {
    agent any

    stages {
        stage('SCM Checkout') {
            steps {
                git url: 'https://github.com/anandasaisoorisetty/webappanand.git', branch: 'main'
            }
        }

        stage('Node Build') {
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

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t anandasaisoorisetty/webappanand:ANAND-PROJECT-${BUILD_NUMBER} ."
                }
            }
        }

        stage('Docker Login and Push Image in Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'Docker_Hub_PWD', variable: 'Docker_Hub_PWD')]) {
                    sh "docker login -u anandasaisoorisetty -p ${Docker_Hub_PWD}"
                }
                sh "docker push  anandasaisoorisetty/java-web-app-docker:ANAND-PROJECT-${BUILD_NUMBER} "
            }
        }
    }
}
