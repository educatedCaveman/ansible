pipeline {
    agent any 

    environment {
        ANSIBLE_REPO = '/var/lib/jenkins/workspace/ansible_master'
        WEBHOOK = credentials('JENKINS_DISCORD')
    }

    //triggering periodically so the code is always present
    // run every friday at 3AM
    triggers { cron('0 3 * * 5') }

    stages {
        // make new ansible code available to drake
        stage('deploy ansible playbooks') {
            steps {
                echo 'deploying ansible playbooks to /home/drake/ansible/'
                sh 'ansible-playbook ${ANSIBLE_REPO}/deploy/deploy_ansible.yml'
            }
        }
        // update the roles
        // the script handles skipping execution for the cron trigger
        stage('execute role update playbooks') {
            steps {
                echo 'checking the last commit for changes to an ansible role, and running the update playbooks, if applicable'
                // sh 'bash ${ANSIBLE_REPO}/maintenance/ansible_role_updates.sh ${ANSIBLE_REPO}'
            }
        }
    }
    post {
        always {
            discordSend \
                description: "${JOB_NAME} - build #${BUILD_NUMBER}", \
                // footer: "Footer Text", \
                // link: env.BUILD_URL, \
                result: currentBuild.currentResult, \
                // title: JOB_NAME, \
                webhookURL: "${WEBHOOK}"
        }
    }
}

