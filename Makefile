env-up:
	docker compose -f docker/docker-compose.yaml up -d --build 

env-down:
	docker compose -f docker/docker-compose.yaml down

env-enter:
	docker exec -w /ansible -it ll-ansible-host bash
