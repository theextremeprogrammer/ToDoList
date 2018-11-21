#!/bin/sh

curl -i -X POST "http://localhost:8080/todos" -H "content-type: application/json" -d '{"title":"Pick up dry cleaning"}'
curl -i -X POST "http://localhost:8080/todos" -H "content-type: application/json" -d '{"title":"Mail holiday cards"}'
curl -i -X POST "http://localhost:8080/todos" -H "content-type: application/json" -d '{"title":"Buy birthday present for mom"}'
