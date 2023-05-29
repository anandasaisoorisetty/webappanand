pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    stages {
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
                sh "docker push  anandasaisoorisetty/webappanand:ANAND-PROJECT-${BUILD_NUMBER} "
            }
        }

        stage('EKS Deploy') {
            steps {
                    sh '''
       aws eks update-kubeconfig --name webappanand-kube --region us-east-1
       sed "s/buildNumber/${BUILD_NUMBER}/g" deploy.yml > deploy-new.yml
       kubectl apply -f deploy-new.yml
       kubectl apply -f svc.yml

         '''
            }
        }
    }
}
