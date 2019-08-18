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
  ansible-playbook-3.7 -i hosts --syntax-check \$pb || exit 1
done	
"""
            }
        }

        stage("Run Server Playbooks") {
            when { 
                allOf {
                    anyOff {
                        expression { return params.RUN_PLAY }
                        triggeredBy 'TimerTrigger' 
                    }
                    branch 'master'
                }
            }
            parallel {
                stage("FreeBSD Servers") {
                    steps {
                        ansiblePlaybook forks: 10,
                            disableHostKeyChecking: true,
                            colorized: true,
                            credentialsId: 'rafi-ssh-key',
                            inventory: 'hosts',
                            vaultCredentialsId: 'ansible-vault',
                            installation: 'FreeBSD Ansible',
                            playbook: 'freebsd-servers.yml'

                        ansiblePlaybook forks: 10,
			                disableHostKeyChecking: true,
                            colorized: true,
                            credentialsId: 'rafi-ssh-key',
                            inventory: 'hosts',
                            vaultCredentialsId: 'ansible-vault',
                            installation: 'FreeBSD Ansible',
			                playbook: 'freebsd-ldapservers.yml'

                        ansiblePlaybook forks: 10,
                            disableHostKeyChecking: true,
                            colorized: true,
                            credentialsId: 'rafi-ssh-key',
                            inventory: 'hosts',
                            vaultCredentialsId: 'ansible-vault',
                            installation: 'FreeBSD Ansible',
                            playbook: 'freebsd-dns.yml'

			            ansiblePlaybook forks: 10,
                            disableHostKeyChecking: true,
                            colorized: true,
                            credentialsId: 'rafi-ssh-key',
                            inventory: 'hosts',
                            vaultCredentialsId: 'ansible-vault',
                            installation: 'FreeBSD Ansible',
                            playbook: 'freebsd-openvpn-servers.yml'

			            ansiblePlaybook forks: 10,
                            disableHostKeyChecking: true,
                            colorized: true,
                            credentialsId: 'rafi-ssh-key',
                            inventory: 'hosts',
                            vaultCredentialsId: 'ansible-vault',
                            installation: 'FreeBSD Ansible',
                            playbook: 'freebsd-rsync-servers.yml'

                        ansiblePlaybook forks: 10,
                            disableHostKeyChecking: true,
                            colorized: true,
                            credentialsId: 'rafi-ssh-key',
                            inventory: 'hosts',
                            vaultCredentialsId: 'ansible-vault',
                            installation: 'FreeBSD Ansible',
                            playbook: 'freebsd-firewall.yml'
                    }
                }
                stage("OpenBSD Servers") {
                    steps {
                        ansiblePlaybook forks: 10,
                            colorized: true,
                            credentialsId: 'rafi-ssh-key',
                            disableHostKeyChecking: true,
                            installation: 'FreeBSD Ansible',
                            inventory: 'hosts',
                            vaultCredentialsId: 'ansible-vault',
                            playbook: 'openbsd-servers.yml'
                        ansiblePlaybook forks: 10,
                            colorized: true,
                            credentialsId: 'rafi-ssh-key',
                            disableHostKeyChecking: true,
                            installation: 'FreeBSD Ansible',
                            inventory: 'hosts',
                            vaultCredentialsId: 'ansible-vault',
		            	    playbook: 'openbsd-gateway.yml'
                    }
                }
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
