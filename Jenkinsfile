pipeline {
    agent any
    parameters {
        choice(name: 'CLOUD_TYPE', choices: ['aws', 'azure'], description: 'Cloud Type (choose azure for now)')
        choice(name: 'ACTION', choices: ['create', 'delete'], description: 'Action to perform')
        string(name: 'NAME', defaultValue: 'dev', description: 'Name of the resources')
        string(name: 'NODE_COUNT', defaultValue: '2', description: 'Number of VMs to create (only used for create action)')
    }
    environment {
        ARM_SUBSCRIPTION_ID = "ad9de94c-559f-4086-a945-07b8228b5c71"
        ARM_TENANT_ID       = "1b8b9614-b026-4602-a1ec-c5c569997a6a"
        ARM_CLIENT_ID       = "7f65c81c-7308-46ec-8d1f-af0d4eb3f982"
        ARM_CLIENT_SECRET   = "tYj8Q~oHyu2rjHkLqJkTMakg1nXyx5txJfiuPbL."
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Process') {
            steps {
                script {
                    if (params.ACTION == "create") {
                        int count = params.NODE_COUNT.toInteger()
                        for (int i = 0; i < count; i++) {
                            def currentVmName = "${params.NAME}-vm-${i}"
                            def backendKey = "${params.NAME}-vm-${i}-tfstate"
                            echo "Creating VM: ${currentVmName} with state key: ${backendKey}"
                            
                            sh """
                            terraform init -backend-config="resource_group_name=backend-rg"                                            -backend-config="storage_account_name=commonbackendsa"                                            -backend-config="container_name=tfstate"                                            -backend-config="key=${backendKey}"
                            """
                            
                            sh """
                            terraform apply -auto-approve -var="env_name=${params.NAME}" -var="vm_index=${i}" -var-file="env.tfvars"
                            """
                        }
                    } else if (params.ACTION == "delete") {
                        def fullVmName = params.NAME
                        def index = sh(script: "echo ${fullVmName} | sed 's/.*-vm-\([0-9]\+\)/\1/'", returnStdout: true).trim()
                        def backendKey = "${fullVmName}-tfstate"
                        echo "Deleting VM: ${fullVmName} (index: ${index}) with state key: ${backendKey}"
                        
                        sh """
                        terraform init -backend-config="resource_group_name=backend-rg"                                        -backend-config="storage_account_name=commonbackendsa"                                        -backend-config="container_name=tfstate"                                        -backend-config="key=${backendKey}"
                        """
                        
                        def baseName = fullVmName.split("-vm-")[0]
                        sh """
                        terraform destroy -auto-approve -var="env_name=${baseName}" -var="vm_index=${index}" -var-file="env.tfvars"
                        """
                    }
                }
            }
        }
    }
    post {
        always {
            echo "Jenkins Pipeline finished."
        }
    }
}
