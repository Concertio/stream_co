pipeline {
    agent {
        dockerfile true
    }

    // check for repo changes every 5 minutes
    triggers{ pollSCM('H/5 * * * *') }

    environment {
        SOURCE_FOLDER = "/var/jenkins_home/workspace/stream"
        OPTIMIZER_MAX_MINUTES = 2
    }

    // Build stages
    stages {
        stage('Run Optimizer Studio Experiment') {
            // optional: only in certain pipeline conditions like release do we opitmize...
            // when { tag "release-*" }
            steps {
                sh 'ls -la; pwd'
                sh label: 'Run Optimizer', returnStdout: true, script: "./docker_run.sh"

                // extract results
                script {
                    env.RESULTS_JSON_FILE = sh (label: 'Extract Results', returnStdout: true, script: './locate_results_file.sh').trim()
                    sh script: "cp ${env.RESULTS_JSON_FILE} ${SOURCE_FOLDER}/optimizer_report.json"

                    def results = readJSON file: "${SOURCE_FOLDER}/optimizer_report.json"
                    echo "improvement is: " + results.metric.improvement + "%"

                    def opt_settings = readYaml file: "${SOURCE_FOLDER}/cont_optimization.yaml"

                    if (results.metric.improvement > opt_settings.optimization.push_results_threshold) {
                        env.COMMIT_OPTIMIZATION = "true"
                    }
                }
            }
        }
        stage("conditionally commit changes") {
            // check end conditions and act accordingly
            when {
                // tag "release-*"
                environment name: 'COMMIT_OPTIMIZATION', value: 'true'
            }
            steps {
                echo "TODO: Commit flags.make back to repo! for next cycle"
            }
        }
    }
}
