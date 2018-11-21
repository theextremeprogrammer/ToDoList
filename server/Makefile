tests units:
	@./gradlew clean build test

integrationtests:
	@./gradlew clean build integrationtest -x test

alltests:
	@./gradlew clean build test integrationtest

start:
	@./gradlew bootrun

deploy:
	@cf push todolistserver -p ./build/libs/todolistapi-0.0.1-SNAPSHOT.jar

localsampledata:
	@./bin/loadSampleData.sh
