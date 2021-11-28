# docker-ide

## How to use
create `ide` user with id 1000 in host machine:
	groupadd ide -g1000
	useradd ide -u1000 -g1000

move your code to `/home/ide/repo`

add `ide` user into `docker` group:
	usermod -aG docker ide

run IDE:
	docker run --name ide -it -v ~/repo:/home/ide/repo bryt/ide

re-enter the IDE after exit:
	docker start -ai ide

