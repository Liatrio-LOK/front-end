/*node {
    stage('Build Image') {
        openshiftBuild (
            namespace: 'ci',
            bldCfg: 'front-end-build',
            checkForTriggeredDeployments: 'true',
            showBuildLogs: 'true',
            verbose: 'false'
        )
    }

    stage('Verify Build') { openshiftVerifyBuild (
            namespace: 'ci',
            bldCfg: 'front-end-build',
            checkForTriggeredDeployments: 'true',
            verbose: 'true'
        )
    }
}*/
  node('ruby') {
    stage('Selenium test') {
      checkout scm
        container('jnlp') {
          stage('run test') {
            sh 'ruby front-end-test-grid.rb'
            input 'promote image?'
          }
        }
      }
  }
node {
    stage('Promote Image') {
        openshiftTag (
            srcStream: 'front-end',
            srcTag: 'dev',
            destinationStream: 'front-end',
            destinationTag: 'latest',
            destinationNamespace: 'ci'
        )
    }
}
