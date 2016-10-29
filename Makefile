.PHONY: doc coverage

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
console: ## Open a PRY console
	bundle exec pry -r ./stack.rb
bench: ## Test the speed...
	bundle exec rake bench:measure
measures: ## Display results
	script/termgraph dat/time.dat
watch: ## Watch changes and run specs
	script/watch
doc: ## Create a YARD documentation
	bundle exec yard
lint: ## Use Rubocop as a linter
	bundle exec rubocop -a
critic: ## Generate a rubycritic report
	bundle exec rubycritic config lib
coverage: ## Generate SIMPLECOV report
	COVERAGE=true bundle exec rspec
