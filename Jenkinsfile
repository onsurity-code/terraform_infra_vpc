pipeline{
    agent any
    environment {
        PATH = "${PATH}:${getTerraformPath()}"
    }

    stages{
        stage('terraform init and apply - dev'){
            steps{
                sh returnStatus: true, script: 'terraform workspace new dev'
                sh "terraform get -update=true"
                sh "terraform init -backend-config=environments/stage/backend.config"
                sh "terraform plan -var-file=environments/stage/variables.tfvars"
                sh "terraform apply -var-file=environments/stage/variables.tfvars  --auto-approve=true"
                // sh "terraform init"
                // sh "terraform apply -var-file=variables.tfvars -auto-approve"
            }
        }
    }
}

def getTerraformPath(){
    def tfHome = tool name: 'terraform', type: 'org.jenkinsci.plugins.terraform.TerraformInstallation'
    // def tfHome = tool name: 'terraform'
    return tfHome
}