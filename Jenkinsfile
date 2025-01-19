pipeline {
    agent any
    environment {
        PROJECT_ID = 'hidden-talon-448304-c4'
        CLUSTER_NAME = 'devops'
        LOCATION = 'asia-east1'
        CREDENTIALS_ID = 'gcp-djvasanta33'
    }

    stages {
        stage('Checkout') {
            steps {
                // Get code from a GitHub repository
                git 'https://github.com/VasantaPKoli/devops-igp.git'
            }
		}

		stage('Compile')
			{
				steps
				{
					// Run Maven on a Unix agent.
					sh 'mvn compile'
				}
			}
		
		stage('Test')
			{
				steps
				{
					sh 'mvn test'
				}
			}
			
		stage('Build')
			{
				steps
				{
					sh 'mvn package'
				}
			}
		
		stage('Build Docker Image')
			{
				steps
				{
					sh 'cp /var/lib/jenkins/workspace/$JOB_NAME/target/ABCtechnologies-1.0.war abc_tech.war'
					sh 'docker build -t devops-igp:$BUILD_NUMBER .'
					sh 'docker tag devops-igp:$BUILD_NUMBER djvasanta33/devops-igp:$BUILD_NUMBER'
				}
			}
			
			stage('Push Docker Image')
			{
				steps
				{
					withDockerRegistry([ credentialsId: "dockerPass", url: "" ])
					{
						sh 'docker push djvasanta33/devops-igp:$BUILD_NUMBER'
						sh 'docker push djvasanta33/devops-igp'
					}
				}
			}
			
			stage('Deploy as Container')
			{
				steps
				{
					sh 'docker run -itd -P djvasanta33/devops-igp:$BUILD_NUMBER'
				}
			}
			
			stage('Deploy to k8s cluster')
			{
				steps
				{
					step([
					    $class: 'KubernetesEngineBuilder',
					    projectId: env.PROJECT_ID,
					    clusterName: env.CLUSTER_NAME,
					    location: env.LOCATION,
					    manifestPattern: 'manifest.yaml',
					    credentialsId: env.CREDENTIALS_ID,
					    verifyDeployments: true])
				}
			}
			
        }
    }
