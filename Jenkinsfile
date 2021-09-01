import groovy.json.JsonSlurperClassic

@NonCPS
def parseJsonToMap(String json){
    final slurper = new JsonSlurperClassic()
    return new HashMap<>(slurper.parseText(json))
}

pipeline {
    agent { label 'windows' }

    parameters {
        string(name: 'SCTASKNUMBER', defaultValue: '', description: '')
        text(name: 'PARAMETER1', defaultValue: '', description: '')
    }
    
    environment {
        def map = parseJsonToMap("${env.PARAMETER1}")
        SERVIDOR = "${map.SERVIDOR}"
        ORIGEM = "${map.ORIGEM}"
        DESTINO = "${map.DESTINO}"
    }

    stages {
        stage('Mudança') {
            steps {
                script {
                    currentBuild.description = "NUMERO DA CHANGE: $env.SCTASKNUMBER"
                }
            }
        }

        stage('ListDeploy'){
            steps {
                powershell './auto-csv.ps1'
            }
        }
        
        //stage('Deploy'){
          //  steps {
            //    powershell './deploy.ps1'
            //}
        //}
    }
}
