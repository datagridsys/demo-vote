node {

    // groovy closures for sending slack message
    def git_commit = 'unknown'
    def git_branch = 'unknown'
    def notify = { co, msg ->
        short_commit = git_commit.take(7)
        slackSend color: "$co", message: "$msg: branch `${git_branch}`, commit " +
            "`${short_commit}`, job `${env.BUILD_TAG}` <${env.BUILD_URL}|Details>",
            tokenCredentialId: 'skopos-slack'
            //@@FIXME:  set the right credential
    }
    //def notify_fail = { msg -> notify('danger', "*FAILED* $msg") }
    def image_name = 'demo-vote'

    def notify_fail = {}

    stage('build') {

        // chown and chmod docker config for jenkins user
        try {
            sh 'sudo chown -R jenkins:jenkins /var/jenkins_home/.docker'
            sh 'sudo chmod 700 /var/jenkins_home/.docker'
            sh 'sudo chmod 600 /var/jenkins_home/.docker/config.json'
        } catch (e) {
        }

        // checkout git repo:  it is possible that what is checked out here is
        // newer than the commit which triggered the pipeline - get the commit
        try {
            checkout scm
            git_commit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
            git_branch = sh(returnStdout: true, script: 'git rev-parse HEAD | ' +
                'git branch -a --contains | grep remotes | sed s/.*remotes.origin.//').trim()
        } catch (e) {
            notify_fail("$image_name repo checkout")
            throw e
        }

        // build the container
        try {
            timeout(300) {
                sh 'make container'
            }
        } catch (e) {
            notify_fail("$image_name image build")
            throw e
        }
    }

    stage('push') {

        // push to docker hub
        try {
            timeout(300) {
                //sh 'make push'
            }
        } catch (e) {
            notify_fail("$image_name image push")
            throw e
        }
    }

    // notify of success
    //notify('good', 'PASSED image build and push')
}
