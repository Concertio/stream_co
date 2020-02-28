pipeline {
    agent {
        dockerfile true
    }

    // check for repo changes every 5 minutes
    triggers{ pollSCM('H/5 * * * *') }

    environment {
        SOURCE_FOLDER = "/var/jenkins_home/workspace/stream build"
    }

    // Build stages
    stages {
        stage('Run Optimizer Studio Experiment') {
            steps {
                sh 'ls -la; pwd'
                sh label: 'Run Optimizer', returnStdout: true, script: "./docker_run.sh"
            }
        }
    }
}
