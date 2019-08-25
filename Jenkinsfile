pipeline {
    agent {
        label 'ansible'
    }
    options {
        // Running the playbooks multiple times seems a bad idea
        disableConcurrentBuilds()
        ansiColor('xterm')
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
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
                    credentialsId: 'rafi-ssh-key',
                    inventory: 'hosts',
                    vaultCredentialsId: 'ansible-vault',
                    installation: 'FreeBSD Ansible',
                    limit: '!freebsd_user_hosts:!openbsd_virtual_hosts',
                    playbook: 'site.yml'
            }
        }
    }

    post {
        always {
            mail to:"rafi@guengel.ch",
            subject:"${JOB_NAME} (${BRANCH_NAME};${env.BUILD_DISPLAY_NAME}) -- ${currentBuild.currentResult}",
            body:"Refer to ${currentBuild.absoluteUrl}"
        }
    }
}
