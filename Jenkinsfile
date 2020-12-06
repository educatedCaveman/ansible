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

        // link ansible files
        stage('deploy') {
            steps {
                // remove existing hosts link
                echo 'removing existing hosts link...'
                sh 'sudo rm /etc/ansible/hosts'
            }
            steps {
                // set new hosts link
                echo 'creating new hosts link...'
                sh 'sudo ln -s ${ANSIBLE_REPO}/hosts /etc/ansible/hosts'
            }
            steps {
                // remove existing ansible.cfg link
                echo 'removing existing ansible.cfg link...'
                sh 'sudo rm /etc/ansible/ansible.cfg'
            }
            steps {
                // set new ansible.cfg link
                echo 'creating new ansible.cfg link...'
                sh 'sudo ln -s ${ANSIBLE_REPO}/hosts /etc/ansible/ansible.cfg'
            }
        }
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

