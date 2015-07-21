# Login to Docker
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS

# Build image
docker build -t smithjw/frank-bot:$BUILDBOX_COMMIT .

# Run container with specs
docker run -e HUBOT_SLACK_TOKEN=xoxb-7834657472-32TecFyNwzjI9UcsMgoTrz3I -d smithjw/frank-bot:$BUILDBOX_COMMIT

# Tag image with current branch name and push when specs are green
docker tag -f smithjw/frank-bot:$BUILDBOX_COMMIT rsmithjw/frank-bot:$BUILDBOX_BRANCH
# docker push smithjw/frank-bot:$BUILDBOX_BRANCH
