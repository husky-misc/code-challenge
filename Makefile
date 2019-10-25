dev_console:
	@docker-compose run --rm api bin/rails c

dev_run:
	@docker-compose up -d

dev_stop:
	@docker-compose stop

dev_setup:
	@docker-compose run --rm api bin/setup bin/rails db:migrate

dev_shell:
	@docker-compose run --rm api ash

tail_dev_logs:
	@docker-compose logs -f

test_run:
	@docker-compose run --rm api bin/rails test
