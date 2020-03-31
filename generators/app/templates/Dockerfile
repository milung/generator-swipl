FROM swipl AS saved-state
COPY *.pl /build/
COPY sources /build/sources/
COPY assets /build/assets/

ENV http_port 80
ENV base_url ''

WORKDIR /build

RUN swipl -o bootfile -c run.pl

FROM swipl

COPY --from=saved-state /build/assets /app/assets/
COPY --from=saved-state /build/bootfile /app/bootfile

WORKDIR /app

ENTRYPOINT ["swipl", "-x", "/app/bootfile"]

CMD ["--server"]