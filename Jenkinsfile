pipeline {
    agent {
        label 'ansible'
    }
    options {
        ansiColor('xterm')
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
    }
    stages {
        stage("Check Syntax") {
            steps {
		sh """
for pb in *.yml
do
  ansible-playbook --syntax-check \$pb || exit 1
done	
"""
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
