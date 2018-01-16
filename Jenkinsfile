node {
    stage('Create Environment') {
        script {
            sh '''
                folder=`echo $JOB_NAME | cut -d/ -f1 | awk '{print tolower($0)}'`
                branch=`echo $BRANCH_NAME | awk '{print tolower($0)}'`
                set +e
                oc get projects | grep "$folder-$branch"
                if [ $? -ne 0 ]; then
                    oc new-project $folder-$branch &&
                    #we assume people are in the group which corresponds to the folder name
                    oc adm policy add-role-to-group admin $folder --namespace=$folder-$branch &&
                    wget https://raw.githubusercontent.com/Liatrio-LOK/microservices-demo/master/deploy/openshift/templates/full_stack_template.yaml &&
                    oc create -f full_stack_template.yaml &&
                    rm full_stack_template.yaml
                fi 
            '''
        }
    }
}

