default:
	@just --list
clean-all:
	docker-compose down -v --rmi
clean-volume:
	docker-compose down -v
clean-image:
	docker-compose down -v
start:
	docker-compose up