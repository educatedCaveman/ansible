pipeline {
    agent any 

    environment {
        ANSIBLE_REPO = '/var/lib/jenkins/workspace/ansible_master'
    }

    stages {
        // make new ansible code available to drake
        stage('deploy ansible playbooks') {
            steps {
                echo 'deploying ansible playbooks to /home/drake/ansible/'
                sh 'ansible-playbook -v ${ANSIBLE_REPO}/deploy_ansible.yml --extra-vars jenkins_ansible=${ANSIBLE_REPO}'
            }
        }

    }

}

