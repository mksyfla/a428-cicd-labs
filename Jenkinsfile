node {
  docker.image('node:16-buster-slim').inside('-p 3000:3000') {
    stage('Build') {
      sh 'npm install'
    }
    stage('Test') {
      sh './jenkins/scripts/test.sh' 
    }
  }

  stage('Checkout') {
    checkout scm
  }

  stage('Build Image') {
    withCredentials([usernamePassword(
      credentialsId: 'docker-hub-mksyfla',
      usernameVariable: 'USER',
      passwordVariable: 'PASSWORD'
    )]) {
      sh 'docker login -u $USER -p $PASSWORD'
      sh 'docker build -t react-app -f Dockerfile .'
      sh 'docker tag react-app:latest $USER/react-app'
      sh 'docker push $USER/react-app'
    }
  }

  stage('Deploy') {
    input message: 'Lanjutkan ke tahap Deploy?'
    sshagent(['ec2-server-key']) {
      sh "ssh -o StrictHostKeyChecking=no -i ec2-user@13.215.248.81 'sudo docker pull mksyfla/react-app:latest'"
      sh "ssh -o StrictHostKeyChecking=no -i ec2-user@13.215.248.81 'sudo docker run -p 3000:3000 -d mksyfla/react-app:latest'"
    }
    sleep(time: 1, unit: 'MINUTES')
  }
}

// pipeline {
//   agent {
//     docker {
//       image 'node:16-buster-slim'
//       args '-p 3000:3000'
//     }
//   }
//   stages {
//     stage('Build') {
//       steps {
//         sh 'npm install'
//       }
//     }
//     stage('Test') {
//       steps {
//         sh './jenkins/scripts/test.sh' 
//       }
//     }
//     stage('Deploy') {
//       steps {
//         input message: 'Lanjutkan ke tahap Deploy?'
//         sh './jenkins/scripts/deliver.sh'
//         sleep(time: 1, unit: 'MINUTES')
//         sh './jenkins/scripts/kill.sh'
//       }
//     }
//   }
// }
