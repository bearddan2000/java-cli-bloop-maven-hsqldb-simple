FROM maven:3.8.6-jdk-11

# install bloop server
RUN apt-get update \
  && wget -O /usr/bin/coursier https://git.io/coursier-cli && chmod +x /usr/bin/coursier \
  && coursier install --dir /usr/bin bloop --only-prebuilt=true \
  && coursier bootstrap bloop --standalone -o bloop

WORKDIR /usr/src/mymaven

COPY bin .

RUN mvn ch.epfl.scala:maven-bloop_2.13:1.5.3:bloopInstall

RUN bloop compile example

RUN bloop run example

CMD [""]
