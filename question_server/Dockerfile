FROM renderedtext/elixir:1.4.5


ENV TERM=xterm
ENV MIX_ENV=prod

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
USER root
RUN chown developer.developer -R /home/developer

USER developer
RUN mix compile

CMD elixir --sname question_server -S mix run --no-halt
