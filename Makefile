hello:
	echo hello

clean:
	rm -rf public/assets

precompile: clean
	docker-compose exec web rails assets:precompile RAILS_ENV=production