# mockserver

A simple mockserver implementation in Dart using Aqueduct, Postgres, Docker

## run

To start server
 
`docker build -t mockserver .`  (in mockserver folder)

`docker run -p 9999:8888 mockserver`


## use


### available endpoints

**add new endpoints**
* POST localhost:9999/mock

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
* GET localhost:9999/mock?name=<name of endpoint>




Necessity: request an external service `https://www.google.com/` from application A with a relative path `/hello/world/15`

Solution: clone this repo, ensure you have a running postgres instance, replace the external service with mockserver in env, e.g.`http://localhost:9999/mock?name=` and send in the current POST. 

Expected: When requesting `<env.var>/hello/world/15` will then return the json content of the response field.

Note: postgres is set up to connect to localhost using `host.docker.internal` which only works on mac. Replace with another postgres docker container or a postgres host running on a server or  google for alternative solutions.

