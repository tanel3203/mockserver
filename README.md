# mockserver

A simple mockserver implementation in Dart using Aqueduct, Postgres, Docker

## overview

_Purpose:_ request an external service `https://www.externalservice.com/` from own development application with a relative path `hello/world/15`, but don't spend money in development environment on requesting external services, just need to request mocked data.

_Necessity:_ Resolve some relative endpoint `hello/world/15` to a local server and add these on the go. This implementation: resolves to `http://localhost:9999/mock?name=`+`hello/world/15` instead of `https://www.externalservice.com/`+`hello/world/15`

_Solution:_ clone this repo, ensure you have a running postgres instance, run mockserver, replace the external service with mockserver in env, e.g.`http://localhost:9999/mock?name=` and send in the current POST. 

_Expected:_ When requesting `<env.var>/hello/world/15` will then return the json content of the response field from the mockserver instead of the external service. 


## dealing with postgres

* _STEP 1:_ commands to execute in `psql` to create the necessary credentials:
```
> create database mockserver2;
> create user mockuser2 with createdb;
> alter user mockuser2 with password 'mockpass2';
> grant all on database mockserver2 to mockuser2;
```

* _STEP 2:_ after the psql part is done, execute `aqueduct db upgrade --connect postgres://mockuser2:mockpass2@localhost:5432/mockserver2` to apply the migration in the initial migration file (not in `psql` mode, use `\q` to get out)

* _STEP 3:_ go to channel.dart and change the postgres connection info (user, pass, db name) to match what you have created for your running postgres db (if you used what I provided here, this is unnecessary).

* _Note:_ postgres is set up to connect to localhost using `host.docker.internal` (change this to `localhost` when running without docker locally) which only works on mac. Replace with another postgres docker container or a postgres host running on a server or  google for alternative solutions. 

* _Note:_ if you want to create more migration files, use `aqueduct db generate`
## run

To start server
 
`docker build -t mockserver .`  (in mockserver folder)

`docker run -p 9999:8888 mockserver`


## use


### available endpoints

**add new endpoints**
* POST localhost:9999/mock

request body:
```
{
	"name": "hello/world/15",
	"response": {
		"helloWorldKey": "15",
		"helloWorldValue": "fifteen"
	}
}
```


**get mocked endpoints**
* GET localhost:9999/mock?name=`hello/world/15`

response body:
```
{
    "helloWorldKey": "15",
    "helloWorldValue": "fifteen"
}
```