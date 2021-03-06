
pipeline {
    agent any
    stages {
        stage('git_clone') {
            steps {
                sh '''
                rm -rf *
                git clone 'https://github.com/banawathbalajinaik/maven_google.com_job.git'
                '''
            }
        }
        stage('mvn_clean') {
            steps {
                sh '''
                pwd
               ls -ll
               mvn clean
                '''
            }
        }
        stage('mvn_compile') {
            steps {
                sh '''
                pwd
               ls -ll
               mvn compile
                '''
            }
        }
        stage('mvn_test_cases') {
            steps {
                sh '''
                ls -ll
                mvn test
                '''
            }
        }
        stage('mvn_package') {
            steps {
                sh '''
                pwd
               ls -ll
               mvn package
                '''
            }
        }
        stage('Sonar_Quality') {
            steps {
                sh '''
                pwd
               ls -ll
               mvn sonar:sonar
                '''
            }
        }
    }
}
