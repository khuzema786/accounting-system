set shell := ["powershell.exe", "/c"]

default:
	@just --list
clean-all:
	docker-compose down -v --rmi all
clean-volume:
	docker-compose down -v
clean-image:
	docker-compose down -v
start:
	docker-compose up