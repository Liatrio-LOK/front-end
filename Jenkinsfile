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

    stage('Tag Image') {
        openshiftTag (
            srcStream: 'front-end',
            srcTag: env.BRANCH_NAME,
            destinationStream: 'front-end',
            destinationTag: 'latest',
            destinationNamespace: 'ci'
        )
    }

}
