FROM ubuntu

RUN apt-get update
RUN apt-get -y install expect redis-server nodejs npm
RUN npm install -g npm

RUN apt-get update && \
    apt-get install -y python-pip && \
    pip install awscli

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

# Create hubot user
RUN	useradd -d /hubot -m -s /bin/bash -U hubot

# Log in as hubot user and change directory
USER	hubot
WORKDIR /hubot

# Install hubot
RUN yo hubot --owner="James Smith <james@cultureamp.com>" --name="frank" --adapter=slack --defaults

# Some adapters / scripts
RUN npm install hubot-slack --save && npm install
RUN npm install hubot-standup-alarm --save && npm install
RUN npm install hubot-auth --save && npm install
RUN npm install hubot-google-translate --save && npm install
RUN npm install hubot-auth --save && npm install
RUN npm install hubot-github --save && npm install
RUN npm install hubot-alias --save && npm install
RUN npm install hubot-youtube --save && npm install
RUN npm install hubot-cheers —save && npm install
RUN npm install hubot-witty —save && npm install
RUN npm install hubot-aws —save && npm install

# Activate some built-in scripts
ADD hubot/hubot-scripts.json /hubot/
ADD hubot/external-scripts.json /hubot/

RUN npm install cheerio --save && npm install

# And go
CMD ["/bin/sh", "-c", "aws s3 cp --region ap-southeast-2 s3://franks-creds/env.sh .; . ./env.sh; bin/hubot --adapter slack"]
# CMD bin/hubot -a slack