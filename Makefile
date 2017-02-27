.PHONY: image push run debug clean nuke backup restore checkpoint

export DOCKER_REPO ?= jtilander
DOCKER_NAME=ldapdump
export TAG ?= test

DATAVOLUMES ?= `pwd`/tmp
DEBUG?=0

DC=docker-compose
DC_FLAGS="-p ldapdump"

ifeq (run,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

VOLUMES=-v /tmp/data:/data
ENVIRONMENT=-e "LDAP_USERNAME=$(LDAP_USERNAME)" -e "LDAP_PASSWORD=$(LDAP_PASSWORD)" -e "DEBUG=$(DEBUG)" -e "LDAP_SERVER=$(LDAP_SERVER)" -e "LDAP_BASE_DN=$(LDAP_BASE_DN)"

image:
	@docker build -t $(DOCKER_REPO)/$(DOCKER_NAME):$(TAG) .
	@docker images $(DOCKER_REPO)/$(DOCKER_NAME):$(TAG)

push:
	@docker push $(DOCKER_REPO)/$(DOCKER_NAME):$(TAG)

run:
	@docker run --rm $(VOLUMES) $(ENVIRONMENT) $(DOCKER_REPO)/$(DOCKER_NAME):$(TAG) $(RUN_ARGS)

debug:
	@docker run --rm -it $(VOLUMES) $(ENVIRONMENT) $(DOCKER_REPO)/$(DOCKER_NAME):$(TAG) bash

clean:
	@echo "Clean"


nuke: clean
	@-docker rm -f `docker ps -q -a -f ancestor=$(DOCKER_REPO)/$(DOCKER_NAME):$(TAG)`
	@-docker rmi -f `docker images -q -a $(DOCKER_REPO)/$(DOCKER_NAME):$(TAG)`

up:
	@$(DC) $(DC_FLAGS) up -d && $(DC) $(DC_FLAGS) logs -f

down:
	@$(DC) $(DC_FLAGS) down

kill:
	@$(DC) $(DC_FLAGS) down -v
