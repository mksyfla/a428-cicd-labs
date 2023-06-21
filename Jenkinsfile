node {
  docker.image('node:16-buster-slim').inside('-p 3000:3000') {
    stage('Build') {
      sh 'npm install'
    }
    stage('Test') {
      sh './jenkins/scripts/test.sh' 
    }

  }

  stage('Build Image') {
    sh 'ls'
    sh 'docker info'
    // sh 'docker build -t react-app .'
    // withCredentials([usernamePassword(
    //   credentialsId: 'docker-hub-mksyfla',
    //   usernameVariable: 'USER',
    //   passwordVariable: 'PASSWORD'
    // )]) {
    //   sh 'docker login -u $USER -p $PASSWORD'
    //   sh 'docker tag react-app $USER/react-app'
    //   sh 'docker push $USER/react-app'
    // }
  }

  // stage('Deploy') {
  //   input message: 'Lanjutkan ke tahap Deploy?'

  //   sshagent(['ec2-server-key']) {
  //     // sh "ssh -o StrictHostKeyChecking=no -i ../dicoding-cicd.pem ec2-user@18.141.12.29 'sudo docker pull mksyfla/react-app'"
  //     sh "ssh -o StrictHostKeyChecking=no -i ../dicoding-cicd.pem ec2-user@18.141.12.29 'sudo docker run -p 3000:3000 -d mksyfla/react-app'"
  //   }

  //   sleep(time: 1, unit: 'MINUTES')
  // }
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
