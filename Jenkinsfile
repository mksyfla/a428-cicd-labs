node {
  docker.image('node:16-buster-slim').inside('-p 3000:3000') {
    stage('Build') {
      sh 'npm install'
    }
    stage('Test') {
      sh './jenkins/scripts/test.sh' 
    }
    stage('Build image') {
      sh 'docker build -t simple-app'
      sh 'docker push simple-app'
    }
    stage('Deploy') {
      def dockerCmd = 'docker run -p 3000:3000 -d simple-app:latest'
      input message: 'Lanjutkan ke tahap Deploy?'
      sh "ssh -o StrictHostKeyChecking=no ec2-user@ec2-18-136-124-35.ap-southeast-1.compute.amazonaws.com ${dockerCmd}"
      sleep(time: 1, unit: 'MINUTES')
    }
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
