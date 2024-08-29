pipeline {
    agent any
    stages {
    
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Image') {
            steps {
                sh 'oc start-build -F etax-frontend --from-dir=.'
            }
        }
    }
}
