pipeline {
    agent {
        dockerfile true
    }

    // check for repo changes every 5 minutes
    triggers{ pollSCM('H/5 * * * *') }

    environment {
        SOURCE_FOLDER = "/var/jenkins_home/workspace/streamtest"
        OPTIMIZER_MAX_MINUTES = 2
    }

    // Build stages
    stages {
        stage('Run Optimizer Studio Experiment') {
            // optional: only in certain pipeline conditions like release do we opitmize...
            //when { 
            //    tag "release-*"
            //    tag "ready-for-perf-test"
            //}
            steps {
                sh 'ls -la; pwd'

                // and... action!
                script {
                    // checkout perf branch
                    git url: "https://github.com/Concertio/stream_co",
                        credentialsId: 'github-userpass',
                        branch: 'dev',
                        name: 'origin'

                    sh 'git branch --set-upstream-to=origin/dev dev'
                    sh 'git reset --hard; git checkout dev' // to get a local branch tracking remote
                    sh 'git pull origin dev'

                    // read cont_optimization settings
                    def opt_settings = readYaml file: "${SOURCE_FOLDER}/cont_optimization.yaml"
                    env.OPTIMIZER_BRANCH_NAME = opt_settings.vcs.branch

                    // run optimizer experiment
                    sh label: 'Run Optimizer', returnStdout: true, script: "./docker_run.sh"

                    // extract results
                    env.RESULTS_JSON_FILE = sh (label: 'Extract Results', returnStdout: true, script: './locate_results_file.sh').trim()
                    sh script: "cp ${env.RESULTS_JSON_FILE} ${SOURCE_FOLDER}/optimizer_report.json"

                    def results = readJSON file: "${SOURCE_FOLDER}/optimizer_report.json"
                    def improvement_line = "improvement: " + results.metric.improvement + "%"
                    echo improvement_line

                    if (results.metric.improvement > opt_settings.optimization.push_results_threshold) {
                        echo "Commit flags.make back to repo! for next cycle, but only if changed"
                        sh 'pwd; git branch; git status'

                        withCredentials([usernamePassword(credentialsId: 'github-userpass', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                            sh label: 'commit the new conf file to perf branch', returnStdout: true, script: 'git commit -m "optimized compilation flags. ' + improvement_line + '" ./flags.make'
                            sh 'git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/Concertio/stream_co HEAD:dev'
                        }
                            
                        // sh label: 'push flags to remote', returnStdout: true, script: "git push --set-upstream origin ${env.OPTIMIZER_BRANCH_NAME}"
                    }
                }
            }
        }
    }
}
