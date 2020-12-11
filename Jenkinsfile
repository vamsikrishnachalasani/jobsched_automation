import groovy.json.JsonOutput
@Library(['PSL@LKG', 'DBPPermissions']) _

// Welcome to the RTF IaC pipeline
// The following diagram shows the stage layout for this parameterized job:
//


boolean is_production_branch = (env.BRANCH_NAME == 'master' || env.BRANCH_NAME.startsWith('release-'))
boolean skipRemainingStages = false

pipeline {
    agent {
        docker {
            label 'aws-centos'
            image 'dbp/iac-tools:master_19'
            registryUrl 'http://autodesk-docker.art-bobcat.autodesk.com/'
            registryCredentialsId 'cosv2_artifactory_user'
            args '-u root'
        }
    }
    stages {
        stage('Check Permissions') {
            steps{
                script{
                    wrap([$class: 'BuildUser']) {
                        def user=BUILD_USER_ID
                        Permissions(user, env.BRANCH_NAME, params.target_environment)
                    }
                }
            }
        }
		stage('run shell script'){
			steps{
				sh './job_and_job_chain_status.sh'
			}
		}
    } // stages
} // pipeline
