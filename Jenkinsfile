//import groovy.json.JsonOutput
//@Library(['PSL@LKG', 'DBPPermissions']) _

// Welcome to the RTF IaC pipeline
// The following diagram shows the stage layout for this parameterized job:
//


//boolean is_production_branch = (env.BRANCH_NAME == 'master' || env.BRANCH_NAME.startsWith('release-'))
//boolean skipRemainingStages = false

pipeline {
    agent any
    
    stages {
	stage('Checkout code') {
        steps {
            checkout scm
        }
    }
    stage('run shell script'){
	steps{
		sh './job_and_job_chain_status.sh'
	}
     }
  } // stages
} // pipeline
