pipeline {
	agent any
		
		environment {
			DockerUser = credentials('DockerUser')
			DockerPass = credentials('DockerPass')
		}
		stages {                 
			stage('Prepare') {                         
				steps {                                 
					echo 'Preparing..'
				}                 
			}                 
			stage('Build') {                         
				steps {                                 
					echo 'Building..'
					//sh 'if [ "$(docker images ${reg} -q)" != "" ]; then docker rmi -f $(docker images ${reg} -q --no-trunc); fi'
					sh 'docker build --rm . -t cristiancristancho/rampup_front'                         
				}                 
			} 
			/*               
			stage('Test') {                         
				steps {                                 
					echo 'Testing...'  
					sh 'docker run --rm --name movieUIjenkinsTest -d challengejenkins:${BUILD_NUMBER} npm test'                        
				}                 
			}*/
			
			stage('push') {
				steps {
					echo 'pushing'
					sh 'docker login -u $DockerUser -p $DockerPass'
					sh 'docker tag cristiancristancho/rampup_front cristiancristancho/rampup_front:${BUILD_NUMBER}'
					sh 'docker push cristiancristancho/rampup_front:${BUILD_NUMBER}'

				}
			}
			/* stage('Check') {                         
				steps {                                 
					echo 'Look the new version on port 8050....'  
					input 'check new version?'
					//sh 'docker stop $(docker ps -aq)'
					//sh 'docker rm $(docker ps -aq)'
					//sh 'docker rmi $( docker images | grep "^<none>" | awk "{print $3}" )'
					//sh 'docker stop challjenkNew'
					//sh 'docker rm challjenkNew'
					sh 'docker run --rm --name challjenkNew -d -p 65000:3030 cristiancristancho/rampup_front:${BUILD_NUMBER}'  
                                 					
				}                 
			} */                  
			stage('Deploy') {                         
				steps {                                 
					echo 'Deploying....'  
					input 'Accept deployment?'
					//sh 'docker stop $(docker ps -aq)'
					// sh 'docker stop challjenkNew'
					// sh 'docker stop challjenk'
					// sh 'docker rm challjenk'
					// sh 'docker run --name challjenk -d -p 8000:3030 cristiancristancho/rampup_front:latest'
					sh 'ssh -i cccc.pem ubuntu@172.23.6.170'
					sh 'if [ "$(docker service ps -q movieUI)" != "" ]; then docker service create --replicas 2 -p 3030:3030 --name movieUI cristiancristancho/rampup_front:latest; fi'
					sh 'docker service update --replicas 2 -p 3030:3030 -env BACKEND_URL=172.23.9.232:3000 --name movieUI cristiancristancho/rampup_front:latest'
				}                 
			}         
		} 
} 
