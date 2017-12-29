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
            namespace: 'sock-shop',
            sourceStream: 'front-end',
            sourceTag: 'latest',
            destinationStream: 'front-end',
            destinationTag: env.BRANCH_NAME,
            destinationNamespace: 'sock-shop'
        )
    }
}
