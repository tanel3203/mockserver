FROM google/dart-runtime

WORKDIR /app
ADD pubspec.* /app/

RUN groupadd -r aqueduct
RUN useradd -m -r -g aqueduct aqueduct
RUN chown -R aqueduct:aqueduct /app

USER aqueduct
RUN pub get --no-precompile

USER root
ADD . /app
RUN chown -R aqueduct:aqueduct /app


USER aqueduct
RUN pub get --offline --no-precompile

EXPOSE 8888

ENTRYPOINT ["pub", "run", "aqueduct:aqueduct", "serve"]