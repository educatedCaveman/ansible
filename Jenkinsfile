pipeline {
    agent any 

    environment {
        ANSIBLE_REPO = '/var/lib/jenkins/workspace/ansible_master'
    }

    stages {

        // experimental, to avoid sudo
        stage('run self-configuring ansible playbook') {
            steps {
                echo 'running ansible playbook to deploy new configs to itself'
            }
        }

        // // remove existing hosts link
        // stage('remove old hosts') {
        //     steps {
                
        //         echo 'removing existing hosts link...'
        //         sh 'sudo rm /etc/ansible/hosts'
        //     }
        // }

        // // set new hosts link
        // stage('link new hosts') {
        //     steps {
                
        //         echo 'creating new hosts link...'
        //         sh 'sudo ln -s ${ANSIBLE_REPO}/hosts /etc/ansible/hosts'
        //     }
        // }

        // // remove existing ansible.cfg link
        // stage('remove old ansible.cfg') {
        //     steps {
        //         echo 'removing existing ansible.cfg link...'
        //         sh 'sudo rm /etc/ansible/ansible.cfg'
        //     }
        // }

        // // set new ansible.cfg link
        // stage('link new ansible.cfg') {
        //     steps {
        //         echo 'creating new ansible.cfg link...'
        //         sh 'sudo ln -s ${ANSIBLE_REPO}/ansible.cfg /etc/ansible/ansible.cfg'
        //     }
        // }

        // make new ansible code available to drake
        stage('deploy ansible playbooks') {
            steps {
                echo 'deploying ansible playbooks to /home/drake/ansible/'
                sh 'ansible-playbook ${ANSIBLE_REPO}/deploy_ansible.yml'
            }
        }

    }

}

