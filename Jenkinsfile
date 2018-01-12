node {
    stage('Build Image') {
        openshiftBuild (
            namespace: 'ci', 
            bldCfg: 'front-end-build', 
            checkForTriggeredDeployments: 'true', 
            showBuildLogs: 'true', 
            verbose: 'false'
        )
    }

    stage('Verify Build') {
        openshiftVerifyBuild (
            namespace: 'ci', 
            bldCfg: 'front-end-build', 
            checkForTriggeredDeployments: 'true', 
            verbose: 'true'
        )
    }

    stage('Verify Deployment') {
        openshiftVerifyDeployment (
            namespace: env.BRANCH_NAME.toLowerCase(), 
            depCfg: 'front-end', 
            verifyReplicaCount: 'true', 
            verbose: 'true'
        )
    }

    stage('Approve Promotion') {
        steps {
          input 'Deploy to Dev?'
        }
    }

    stage('Promote Image') {
        openshiftTag (
            srcStream: 'front-end',
            srcTag: env.BRANCH_NAME,
            destinationStream: 'front-end',
            destinationTag: 'latest',
            destinationNamespace: 'ci'
        )
    }

}
