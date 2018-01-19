node {
    stage('Create Environment') {
        script {
            sh  '''
                echo $(echo $JOB_NAME | awk 'match($0, /[a-zA-Z0-9-]*/) {print tolower(substr($0, RSTART, RLENGTH))}') > REPOSITORY;
                echo $(echo $JOB_NAME | awk '{print tolower($0)}' | awk 'sub("/", "-")') > PROJECT_NAME;
           
                if ! oc describe project $(cat PROJECT_NAME); then
                    oc new-project $(cat PROJECT_NAME) &&
                    oc adm policy add-role-to-group admin $(cat REPOSITORY) --namespace=$(cat PROJECT_NAME) &&
                    wget https://raw.githubusercontent.com/Liatrio-LOK/microservices-demo/LOK-115-POC/deploy/openshift/templates/lok_115_template.yaml &&
                    oc create -f lok_115_template.yaml &&
                    rm lok_115_template.yaml;
                fi
                '''
        }
    }

    stage('Build Image') {
        script {
            commitId = sh (
              script: ''' 
                      git ls-remote git://github.com/Liatrio-LOK/front-end.git \
                      | grep ${BRANCH_NAME} | cut -f 1
                      ''',
              returnStdout: true
            ).trim()
            
            print commitId
        }   

        openshiftBuild (
            namespace: 'sock-shop', 
            bldCfg: 'front-end-build', 
            checkForTriggeredDeployments: 'true', 
            showBuildLogs: 'true', 
            commitID: commitId,
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

