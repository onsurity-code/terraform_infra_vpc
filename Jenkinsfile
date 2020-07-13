pipeline {

//    parameters {
//     choice(name: 'action', choices: 'create VPC', description: 'Create VPC/update  VPC')
// 	string(name: 'Environment', defaultValue : 'dev', description: "VPC creation;eg AWS creates VPC named `aws-a0001-aps1-1a-d-vpc-onsy-onsy-devvpc01`.")
//   }

    parameters {
		choice(name: 'action', choices: 'create VPC', description: 'Create VPC/update  VPC')
		choice(name: 'environment', choices : 'demo', description: "VPC creation;eg AWS creates VPC named `aws-a0001-aps1-1a-d-vpc-onsy-onsy-devvpc01`. \nd -> dev\ns -> stage\nt -> tools\nu -> UAT\np -> prod\nx -> demo")
  	}
		// choice(name: 'environment', choices : 'dev\nstage\ntools\nUAT\nprod\ndemo', description: "VPC creation;eg AWS creates VPC named `aws-a0001-aps1-1a-d-vpc-onsy-onsy-devvpc01`. \nd -> dev\ns -> stage\nt -> tools\nu -> UAT\np -> prod\nx -> demo")
  agent any

  stages {
    stage('checkout') {
        steps {
            git url: 'https://github.com/ashishsarkar/terraform_infra_vpc.git'
        }
    }
	stage('Setup') {
		steps {
			script {
				currentBuild.displayName = "#" + env.BUILD_NUMBER + " " + params.action + " AWS-VPC-" + params.environment
				plan = params.environment + '.plan'
			}
		}
	}
    stage('Set Terraform path') {
        steps {
            script {
                def tfHome = tool name: 'terraform'
                env.PATH = "${tfHome}:${env.PATH}"
            }
            sh 'terraform -version'
        }
    }
    stage('TF Plan') {
      when {
        expression { params.action == 'create VPC' }
		}	
		steps {
			script {
				sh """
					echo "Initiating FORMAT"
					terraform fmt
					echo "Completed FORMAT"

					echo "Initiating UPDATE"
					terraform get -update=true
					echo "Completed Update"

					echo "Initiating INIT"
                	terraform init -backend-config=environments/${params.environment}/backend.config
					echo "Completed INIT"

					echo "Initiating PLAN"
                	terraform plan -var-file=environments/${params.environment}/variables.tfvars
					echo "Initiating PLAN"
					
					echo "Completed FORMAT UPDATE INIT PLAN"
					echo ${params.environment}
				"""
					sleep 10
					}
			}
	}
    stage('TF Apply') {
      when {
        expression { params.action == 'create VPC' }
		}	
		steps {
			script {
				sh """
					terraform apply -var-file=environments/${params.environment}/variables.tfvars  --auto-approve=true
				"""
        }
      }
    }

	// Created for future enhancement
    // stage('TF Destroy') {
    //   when {
    //     expression { params.action == 'destroy' }
    //   }
    //   steps {
    //     script {
	// 		dir('eksterraform') {
	// 			withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_Credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
	// 			sh """
	// 			terraform workspace select ${params.environment}
	// 			terraform destroy -auto-approve
	// 			"""
	// 			}
	// 		}
    //     }
    //   }
    // }
  }
}
