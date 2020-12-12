pipeline {
    agent any 

    environment {
        SLACK_WEBHOOK_URL = credentials('slack_webhook_url_dev_sec_ops')
        JENKINS_SCRIPTS = '/var/lib/jenkins/workspace/Jenkins_self_deploy'
        ANSIBLE_REPO = '/var/lib/jenkins/workspace/Ansible_pipeline_master'
    }

    stages {
        // notify
        stage('notify_start') {
            steps {
                sh 'python3 ${JENKINS_SCRIPTS}/slack.py ${SLACK_WEBHOOK_URL} start'
            }
        }

        // remove existing hosts link
        stage('remove old hosts') {
            steps {
                
                echo 'removing existing hosts link...'
                sh 'sudo rm /etc/ansible/hosts'
            }
        }

        // set new hosts link
        stage('link new hosts') {
            steps {
                
                echo 'creating new hosts link...'
                sh 'sudo ln -s ${ANSIBLE_REPO}/hosts /etc/ansible/hosts'
            }
        }

        // remove existing ansible.cfg link
        stage('remove old ansible.cfg') {
            steps {
                echo 'removing existing ansible.cfg link...'
                sh 'sudo rm /etc/ansible/ansible.cfg'
            }
        }

        // set new ansible.cfg link
        stage('link new ansible.cfg') {
            steps {
                echo 'creating new ansible.cfg link...'
                sh 'sudo ln -s ${ANSIBLE_REPO}/ansible.cfg /etc/ansible/ansible.cfg'
            }
        }

        // make new ansible code available to drake
        //TODO:
    }

    // notify on complete
    post {
        success {
            sh 'python3 ${JENKINS_SCRIPTS}/slack.py ${SLACK_WEBHOOK_URL} end'
        }
        failure {
            sh 'python3 ${JENKINS_SCRIPTS}/slack.py ${SLACK_WEBHOOK_URL} error'
        }
    }
}

