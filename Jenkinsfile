/*node {
    stage('Build Image') {
        openshiftBuild (
            namespace: 'sock-shop',
            bldCfg: 'front-end-build',
            checkForTriggeredDeployments: 'true',
            showBuildLogs: 'true',
            verbose: 'false'
        )
    }

    stage('Verify Build') { openshiftVerifyBuild (
            namespace: 'sock-shop',
            bldCfg: 'front-end-build',
            checkForTriggeredDeployments: 'true',
            verbose: 'true'
        )
    }
}*/
podTemplate(label: 'slave-pod', cloud: 'openshift', containers: [
    containerTemplate(name: 'selenium-firefox', image: 'liatrio/selenium-firefox', ttyEnabled: true, command: 'cat'),
  ]) {
  node ('slave-pod') {
    stage('Build Image') {
        openshiftBuild (
            namespace: 'sock-shop',
            bldCfg: 'front-end-build',
            checkForTriggeredDeployments: 'true',
            showBuildLogs: 'true',
            verbose: 'false'
        )
    }

    stage('Verify Build') { openshiftVerifyBuild (
            namespace: 'sock-shop',
            bldCfg: 'front-end-build',
            checkForTriggeredDeployments: 'true',
            verbose: 'true'
        )
    }
    stage('Selenium test') {
        checkout scm
        container('selenium-firefox') {
          stage('run test') {
            sh 'ruby front-end-test-grid.rb'
            input 'promote image?'
          }
        }
    }
    stage('Promote Image') {
        openshiftTag (
            srcStream: 'front-end',
            srcTag: 'dev',
            destinationStream: 'front-end',
            destinationTag: 'latest',
            destinationNamespace: 'sock-shop'
        )
    }
  }
}
/*node {
    stage('Promote Image') {
        openshiftTag (
            srcStream: 'front-end',
            srcTag: 'dev',
            destinationStream: 'front-end',
            destinationTag: 'latest',
            destinationNamespace: 'sock-shop'
        )
    }
}
pipeline {
  agent none
  stages {
    stage('Selenium test') {
      agent {
        docker {
            image 'liatrio/selenium-firefox'
            //args '--network=plumbing_default'
        }
      }
      steps{
        //checkout scm
        sh 'ruby front-end-test-grid.rb'
        input 'promote image?'
      }
    }
  }
}*/
