pipeline {
    agent any

    stages {
        stage('Cleanup WorkSpace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout from SCM') {
            steps {
                git url: 'https://github.com/anandasaisoorisetty/webappanand.git', branch: 'main'
            }
        }

        stage('Installing Angular dependencies') {
            steps {
                script {
                    // Set PATH environment variable
                    env.PATH = "/usr/local/bin:${env.PATH}"

                    // Install Node.js and npm
                    tool 'NodeJS'
                    sh 'npm install'
                    sh 'npm install @angular/cli'
                    sh 'npm install sonar-scanner --save-dev'
                    sh 'npm install puppeteer --save-dev'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build Angular app
                    sh 'npm run build'
                }
            }
        }

        stage('Unit Testing') {
            steps {
                script {
                    // Set the path to the Chrome binary for Unit Testing
                    sh 'export CHROME_BIN=/path/to/chrome-binary '

                    // Run unit tests
                    sh 'npm run test -- --karma-config=karma.conf.puppeteer.js'
                }
            }
        }

        stage('Code Analysis') {
            steps {
                script {
                    // Perform code analysis using SonarQube
                    def sonarScanner = 'node_modules/sonar-scanner/bin/sonar-scanner'
                    sh "${sonarScanner}"
                    sh 'npm run sonar'
                }
            }
        }

        stage('Package Artifacts') {
            steps {
                script {
                    // Create deployable artifacts
                    sh 'npm run package'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t anandasaisoorisetty/webappanand:ANAND-PROJECT-${BUILD_NUMBER} ."
                }
            }
        }

        stage('SonarQube Analysis after Docker Build') {
            steps {
                script {
                    // Perform SonarQube analysis after Docker image is built
                    def sonarScanner = 'node_modules/sonar-scanner/bin/sonar-scanner'
                    sh "${sonarScanner}"
                    sh 'npm run sonar'
                }
            }
        }

        stage('Docker Login and Push Image to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'Docker_Hub_PWD', variable: 'Docker_Hub_PWD')]) {
                    sh "docker login -u anandasaisoorisetty -p ${Docker_Hub_PWD}"
                }
                sh "docker push anandasaisoorisetty/webappanand:ANAND-PROJECT-${BUILD_NUMBER}"
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

    post {
        always {
            script {
                // Send email report
                emailext body: "Pipeline execution status: ${currentBuild.result}",
                         subject: "Pipeline Report - ${currentBuild.result}",
                         to: 'asoorisetty@gmail.com'
            }
        }
    }
}
