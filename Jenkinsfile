node {
  docker.image('node:16-buster-slim').inside('-p 3000:3000') {
    stage('Build') {
      sh 'npm install'
    }
    stage('Test') {
      sh './jenkins/scripts/test.sh' 
    }
    stage('Deploy') {
      input message: 'Lanjutkan ke tahap Deploy?'
      
      withCredentials([sshUserPrivateKey(credentialsId: '05f2f461-d8f1-415e-9c20-be77df479fb6', keyFileVariable: 'KEY_FILE')]) {
        def ec2Username = 'ec2-user'
        def ec2PublicIp = 'ec2-54-255-170-104.ap-southeast-1.compute.amazonaws.com'
        def dockerCommand = "docker stop my-app || true && docker rm my-app || true && docker run -d -p 3000:3000 --name my-app node:16-buster-slim"
        
        sshagent(['KEY_FILE']) {
          sshCommand remote: "ssh -o StrictHostKeyChecking=no -i \$KEY_FILE ${ec2Username}@${ec2PublicIp} '${dockerCommand}'"
        }
      }

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
