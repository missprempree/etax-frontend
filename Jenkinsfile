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
        
        stage("Run Ansible Job Template"){
           steps {
               ansibleTower jobTemplate: 'yatphiroon-app-job-template', 
                           jobType: 'run', 
                           throwExceptionWhenFail: false, 
                           towerCredentialsId: 'ansible', 
                           towerLogLevel: 'false', 
                           towerServer: 'cd-ansible'
           }
        }
    }
}
