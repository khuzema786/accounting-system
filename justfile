default:
	@just --list
fresh-start:
	docker-compose down -v
	docker-compose up
start:
	docker-compose up