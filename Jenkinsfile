pipeline {
    agent {
        label 'ansible'
    }
    options {
        // Running multiple playbooks in parallel seems like a bad idea
        disableConcurrentBuilds()
        ansiColor('xterm')
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '30')
        timestamps()
        timeout(time: 90, unit: 'MINUTES')
    }

    parameters {
        booleanParam(name: 'RUN_PLAY', defaultValue: false, description: 'Run Playbooks')
    }

    triggers {
        cron 'H 21 * * *'
    }

    stages {
        stage("Check Syntax") {
            steps {
		sh """
for pb in *.yml
do
  ansible-playbook -i hosts --syntax-check \$pb || exit 1
done
"""
            }
        }

        stage("Run Server Playbooks") {
            when {
                allOf {
                    anyOf {
                        expression { return params.RUN_PLAY }
                        triggeredBy 'TimerTrigger'
                    }
                    branch 'master'
                }
            }
            steps {
                ansiblePlaybook forks: 10,
                    disableHostKeyChecking: true,
                    colorized: true,
                    credentialsId: 'c9342123-1fc9-4ba3-a681-e5b0dd647322',
                    inventory: 'hosts',
                    vaultCredentialsId: 'ansible-vault',
                    installation: 'FreeBSD Ansible',
                    playbook: 'site.yml'
            }
        }
    }

    post {
        unsuccessful {
            mail to:"rafi@guengel.ch",
            subject:"${JOB_NAME} (${BRANCH_NAME};${env.BUILD_DISPLAY_NAME}) -- ${currentBuild.currentResult}",
            body:"Refer to ${currentBuild.absoluteUrl}"
        }
    }
}
