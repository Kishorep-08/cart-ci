@Library ('jenkins-shared-library') _

def configMap = [
    project: "roboshop",
    component: "cart",
]

if (env.BRANCH_NAME == 'main') {
    echo "Please follow the CR process"
}
else {
    nodeJSEKSpipeline(configMap)
}