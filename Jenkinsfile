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

    stage('Create new deployment') {
        openshiftCreateResource (
            jsonyaml: """
apiVersion: v1
kind: DeploymentConfig
metadata:
  name: front-end-blue
  namespace: sock-shop
spec:
  replicas: 1
  selector:
    name: front-end-blue
  strategy:
    activeDeadlineSeconds: 21600
    resources: {}
    rollingParams:
      intervalSeconds: 1
      maxSurge: 25%
      maxUnavailable: 25%
      timeoutSeconds: 600
      updatePeriodSeconds: 1
    type: Rolling
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: front-end-blue
    spec:
      containers:
      - image: 172.30.1.1:5000/sock-shop/front-end
        imagePullPolicy: IfNotPresent
        name: front-end
        #command:
        # - npm
        #args:
        # - test
        ports:
        - containerPort: 8079
          protocol: TCP
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        securityContext:
          readOnlyRootFilesystem: false
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      nodeSelector:
        beta.kubernetes.io/os: linux
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
  test: false
  triggers:
  - type: ConfigChange
  - imageChangeParams:
      automatic: true
      containerNames:
      - front-end
      from:
        kind: ImageStreamTag
        name: front-end:latest
        namespace: sock-shop
    type: ImageChange
            
            """,
            namespace: 'sock-shop', 
            verbose: 'false'
        )
    }

    stage('reroute traffic') {
      steps {
        sh "oc patch route/front-end -p \'{\"spec\":{\"to\":{\"name\":\"front-end-blue\"}}}\'"
      }
    }

}
