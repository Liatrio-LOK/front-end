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
podTemplate(label: 'node', cloud: 'openshift', containers: [
    containerTemplate(name: 'nodejs', image: 'node:6-alpine', ttyEnabled: true, command: 'cat'),
  ]) {
  node('node') {
      stage('Selenium test') {
        checkout scm
        container('nodejs'){
          stage('run test') {
            sh 'npm install'
            sh 'node front-end-test.js'
            input 'promote image?'
          }
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
