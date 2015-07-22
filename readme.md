Doom HuBot
===========

Idea: Setup HuBot inside a Docker container and run it on AWS with the ability to automatically build and deploy with BuildKite.

[![Build status](https://badge.buildkite.com/d3efbf8e17da885df4c2cbbb9f1bd0406384bb6d7c9af68657.svg)](https://buildkite.com/ca/building-frank)

### Deploy manual to AWS ECS
1. Setup new EC2 Container Instance as described [here](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_GetStarted.html)
2. Register task definition
      aws ecs register-task-definition --cli-input-json file://$HOME/../hubot-aws-task.json
3. Start task instances
      aws ecs run-task --cluster default --task-definition hubot:X --count 1



### How to build and run it
    docker build -t doom-bot .
    docker run -e HUBOT_SLACK_TOKEN=xxx -d doom-bot

### Add new scripts
1. Add the following line in the dockerfile to install the NodeJS module:

    RUN npm install [MyHuBotModule] --save && npm install

2. Extend the external-scripts.json file with the name of the NodeJS module:

  [ "...",
    "MyHuBotModule"
    ]


### Next steps
* Deploy container automatically to AWS ECS
* Where to configure passwords (Slack, ...) -> https://aws.amazon.com/blogs/aws/category/ec2-container-service/
* Persistent brain (Redis?)
* Deploy EC2 Container Instance via Cloudfront
* Rights & Roles
