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
    sh 'docker build -t react-app-image .'
    sh 'docker tag react-app-image react-app'
    sh 'docker push react-app'
  }

  stage('Deploy') {
    def dockerPull = 'docker pull react-app'
    def dockerCmd = 'docker run -p 3000:3000 -d react-app'

    input message: 'Lanjutkan ke tahap Deploy?'

    sshagent(['ec2-jenkins-submission-dicoding']) {
      sh "ssh -o StrictHostKeyChecking=no -i ../dicoding-cicd.pem ec2-user@3-1-205-62 ${dockerPull}"
      sh "ssh -o StrictHostKeyChecking=no -i ../dicoding-cicd.pem ec2-user@3-1-205-62 ${dockerCmd}"
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
