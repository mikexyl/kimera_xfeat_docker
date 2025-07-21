IMAGE_NAME ?= kimera_xfeat
TAG ?= latest
USERNAME ?= kimera

build:
	docker build --build-arg USERNAME=$(USERNAME) -t $(IMAGE_NAME):$(TAG) .

.PHONY: build start

start:
	@if [ $$(docker ps -a -q -f name=$(IMAGE_NAME)_container) ]; then \
	  if [ $$(docker ps -q -f name=$(IMAGE_NAME)_container) ]; then \
		echo "Container is already running."; \
		docker exec -it $(IMAGE_NAME)_container bash; \
	  else \
		docker start $(IMAGE_NAME)_container; \
		docker exec -it $(IMAGE_NAME)_container bash; \
	  fi \
	else \
	  docker run --gpus all --network=host -it --name $(IMAGE_NAME)_container -v ~/workspaces/kimera_noetic_ws/src:/workspaces/src -v ~/workspaces/datasets:/datasets $(IMAGE_NAME):$(TAG) bash; \
	fi
