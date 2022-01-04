pipeline {
    agent any 

    environment {
        ANSIBLE_REPO = '/var/lib/jenkins/workspace/ansible_master'
    }

    //triggering periodically so the code is always present
    // run every friday at 3AM
    triggers { cron('0 3 * * 5') }

    stages {
        // make new ansible code available to drake
        stage('deploy ansible playbooks') {
            steps {
                echo 'deploying ansible playbooks to /home/drake/ansible/'
                sh 'ansible-playbook ${ANSIBLE_REPO}/deploy/deploy_ansible.yml --extra-vars jenkins_ansible=${ANSIBLE_REPO}'
            }
        }
        // update the roles
        // the script handles skipping execution for the cron trigger
        stage('execute role update playbooks') {
            steps {
                echo 'checking the last commit for changes to an ansible role, and running the update playbooks, if applicable'
                sh 'bash ${ANSIBLE_REPO}/maintenance/ansible_role_updates.sh ${ANSIBLE_REPO}'
            }
        }
    }
}

