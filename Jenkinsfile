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
					sh 'docker build --rm . -t rampup_front:${BUILD_NUMBER}'                         
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
					sh 'docker tag rampup_front:${BUILD_NUMBER} cristiancristancho/rampup_front:${BUILD_NUMBER}'
					sh 'docker push cristiancristancho/rampup_front:${BUILD_NUMBER}'

				}
			}
			stage('Check') {                         
				steps {                                 
					echo 'Look the new version on port 8050....'  
					input 'check new version?'
					//sh 'docker stop $(docker ps -aq)'
					//sh 'docker rm $(docker ps -aq)'
					//sh 'docker rmi $( docker images | grep "^<none>" | awk "{print $3}" )'
					//sh 'docker stop challjenkNew'
					//sh 'docker rm challjenkNew'
					sh 'docker run --rm --name challjenkNew -d -p 65000:3030 rampup_front:${BUILD_NUMBER}'  
                                 					
				}                 
			}                  
			stage('Deploy') {                         
				steps {                                 
					echo 'Deploying....'  
					input 'Accept deployment?'
					//sh 'docker stop $(docker ps -aq)'
					//sh 'docker stop challjenk'
					sh 'docker stop challjenkNew'
					//sh 'docker rm challjenk'
					sh 'docker run --name challjenk -d -p 8000:3030 cristiancristancho/rampup_front:latest'
                                 					
				}                 
			}         
		} 
} 
