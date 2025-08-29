pipeline {
    agent any
    environment {
        REGISTRY = "devesh11411"
        APP_NAME = "shopease-backend"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/DeveshRathod/Shopease-backend.git'
            }
        }

        stage('Determine Image Tag') {
            steps {
                script {
                    // Get commit message and sanitize
                    env.IMAGE_TAG = sh(script: "git log -1 --pretty=%s | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-'", returnStdout: true).trim()
                    echo "Using commit message as IMAGE_TAG: ${env.IMAGE_TAG}"
                }
            }
        }

        stage('Build & Push Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker build -t $REGISTRY/$APP_NAME:$IMAGE_TAG .
                            docker push $REGISTRY/$APP_NAME:$IMAGE_TAG
                        '''
                    }
                }
            }
        }
    }
}
