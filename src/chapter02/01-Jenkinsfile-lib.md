132c8852-2584-4e6b-a68b-7d5674d598f1

# Import a Jenkins Library without Global Jenkins Settings

**Jenkins library structure**
```
(root)
+- vars/
|   +- init.groovy
```
**init.groovy from library**
```groovy
def call(String name = 'Honua') {
    env.GREETINGS = "Aloha $name!"
}
```

**Jenkinsfile in another project**
```groovy
library(
    identifier: 'custom-jenkins-library@master',
    retriever: modernSCM(
        [
            $class: 'GitSCMSource',
            remote: 'https://github.com/tveal/fake-repo-changeme.git',
            credentialsId: 'jenkins-creds-id'
        ]
    )
)

pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                script { init() }
            }
        }
        stage('Greetings') {
            steps {
                echo "$GREETINGS" // Aloha Honua!
            }
        }
    }
}
```

Resources
- https://jenkins.io/doc/book/pipeline/shared-libraries/
- https://jenkins.io/doc/book/pipeline/syntax/
