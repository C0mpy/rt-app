.PHONY: image.build image.run image.test image.push image.pull
.PHONY: create-deploy deploy k8s-shell console watch lint
.PHONY: config-gen abort-on-uncommited-changes copy-mix.lock

SEMAPHORE_EXECUTABLE_UUID?=""
GIT_HASH=$(shell git log --format=format:'%h' -1)
TAG?=$(GIT_HASH)-$(SEMAPHORE_EXECUTABLE_UUID)
REPO=renderedtext/usvc_otisak
IMAGE=$(REPO):$(TAG)
IMAGE_LATEST=$(REPO):latest

INTERACTIVE_SESSION=\
          -v $$PWD/home_dir:/home/developer \
          -v $$PWD:/home/developer/prj \
          -e DB_URL="ecto://postgres:postgres@localhost/postgres" \
          --user developer \
          --rm \
					--network=host \
          --workdir="/home/developer/prj" \
          -it renderedtext/elixir:1.4.5

CMD?=/bin/bash
console:
	# docker run -p 4000:4000 $(INTERACTIVE_SESSION)  /bin/bash
	docker run -p 4000:4000 $(INTERACTIVE_SESSION) $(CMD)

start_postgres:
	docker run -d -p 5432:5432 --rm --network=host --name postgres postgres

image.build:
	docker build --cache-from $(IMAGE_LATEST) -t $(IMAGE) .
	docker tag $(IMAGE) $(IMAGE_LATEST)
	$(eval size=$(shell wc -c <mix.lock ))
	if [ $(size) -lt 5 ]; then $(MAKE) copy-mix.lock image.build; fi

image.run: image.build
	docker run -p 4000:4000 -it $(IMAGE)

image.test: image.build config-gen
	docker-compose build
	docker-compose up -d
	./entry_point.sh
	docker-compose down

create-deploy: abort-on-uncommited-changes image.push config-gen
	kubectl create -f deploy.yml
	kubectl get svc/usvc-otisak

deploy: abort-on-uncommited-changes image.push config-gen
	kubectl apply -f deploy.yml
	kubectl get svc/usvc-otisak

k8s-shell:
	$(eval pod_name=$(shell kubectl get po -l app=cluster-portal -o jsonpath={.items[*].metadata.name}))
	kubectl exec -it $(pod_name) -- /bin/bash

watch:
	docker run $(INTERACTIVE_SESSION)  mix do deps.get, test.watch

lint:
	docker run $(INTERACTIVE_SESSION)  mix do credo

image.push: image.build
	docker push $(IMAGE)
	docker push $(IMAGE_LATEST)

image.pull:
	docker pull $(IMAGE)
	docker pull $(IMAGE_LATEST)

config-gen:
	mix usvc.cfg_gen $(TAG)

abort-on-uncommited-changes:
	git diff-index --quiet HEAD --

copy-mix.lock:
	$(eval cid=$(shell docker create $(IMAGE)))
	echo $(cid)
	docker cp $(cid):/home/developer/prj/mix.lock ./mix.lock
	docker rm -v $(cid)
