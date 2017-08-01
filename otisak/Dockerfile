FROM renderedtext/elixir:1.4.5


ENV TERM=xterm
ENV MIX_ENV=prod

RUN apt-get update && apt-get install -y postgresql-client

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/developer

ENV HOME /home/developer
WORKDIR /home/developer/prj

COPY mix* ./
COPY config/ config/

RUN chown developer.developer -R /home/developer

USER developer
RUN mix do local.hex --force, local.rebar --force, deps.get, compile

COPY lib lib/
COPY test test/

COPY priv priv/
COPY entry_point.sh ./

USER root
RUN chown developer.developer -R /home/developer

USER developer
RUN mix compile

CMD elixir --sname usvc_otisak -S mix run --no-halt
