
FROM ubuntu

# Environment variables are accessible during image build stage. They will also persist in the image and available when run the container.
# ENV username="nan"

# ARG creates a variable that is only accessible during image build stage.
ARG username="nan"
ARG software='sudo net-tools wget curl git python3'
# exec form needs double quotes
RUN ["mkdir", "/home/${username}"]

# shell form with /bin/sh -c
RUN apt-get update
RUN apt-get install $software -y

# shell form access environment variables doesn't need "", can have an optional curly brace {}
RUN useradd -mU -s /bin/bash ${username}
RUN usermod -aG sudo $username
RUN chown $username:$username /home/$username

# user doesn't need a password
RUN passwd -d $username
RUN passwd -d root


EXPOSE 8000

USER $username
WORKDIR /home/$username