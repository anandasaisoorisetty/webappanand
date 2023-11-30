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
                    // tool 'NodeJS'
                    sh 'npm install'
                    sh 'npm install @angular/cli'
                    sh 'npm install sonar-scanner --save-dev'
                    sh 'npm install puppeteer --save-dev'
                }
            }
        }

        stage('Code Analysis') {
            steps {
                script {
                    // Perform code analysis using SonarQube
                    sh './sonar_analysis.sh'
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
                    sh 'export CHROME_BIN=/usr/bin/google-chrome '

                    // Run unit tests
                    sh 'npm run test -- --browsers ChromeHeadlessNoSandbox'
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

        // Uncomment the following stage if you want to include Image Scan
        /*
        stage('Image Scan') {
            steps {
                sh '''
                    sed "s/buildNumber/$1/g" image_scan.sh > image_scan-new.sh
                    chmod +x image_scan-new.sh
                    bash image_scan-new.sh
                '''
            }
        }
        */

        stage('Docker Login and Push Image to Docker Hub') {
            when {
                expression {
                    currentBuild.resultIsBetterOrEqualTo('SUCCESS') // Only execute if the build result is SUCCESS
                }
            }
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

        // Uncomment the following stage if you want to include ECS Deploy
        /*
        stage('ECS Deploy') {
            steps {
                sh '''
                    chmod +x changebuildnumber.sh
                    ./changebuildnumber.sh $BUILD_NUMBER
                    sh -x ecs-auto.sh
                '''
            }
        }
        */
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
