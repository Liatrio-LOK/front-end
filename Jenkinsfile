podTemplate(label: 'nodejs', cloud: 'openshift', containers: [
  containerTemplate(name: 'jnlp', image: 'openshift/jenkins-slave-nodejs-centos7', ttyEnabled: true, command: 'cat'),
]) {
  node('nodejs') {
      stage('unit tests') {
        checkout scm
        container('jnlp'){
          sh 'make test'
        }
      }
  }
  node {
      stage('Build Image') {
          openshiftBuild (
              namespace: 'sock-shop', 
              bldCfg: 'front-end-build', 
              checkForTriggeredDeployments: 'true', 
              showBuildLogs: 'true', 
              verbose: 'false'
          )
      }

      stage('Tag Image') {
          openshiftTag (
              sourceStream: 'front-end',
              sourceTag: 'latest',
              destinationStream: 'front-end',
              destinationTag: env.BRANCH_NAME,
              destinationNamespace: 'sock-shop'
          )
      }

  }
}
