.PHONY: build
build:
	docker build . -t ide

.PHONY: push
push:
	docker tag ide bryt/ide:latest
	docker push bryt/ide:latest

.PHONY: dev
dev:
	docker run -it --rm -v /home/ubuntu/repo/docker-ide/.emacs.d:/home/xin/.emacs.d ide

.PHONY: run
run:
	docker run -it --rm ide
