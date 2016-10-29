.PHONY: doc coverage

console:
	bundle exec pry -r ./stack.rb
bench:
	bundle exec rake bench:measure
measures:
	script/termgraph dat/time.dat
watch:
	script/watch
doc:
	bundle exec yard
lint:
	bundle exec rubocop -a
critic:
	bundle exec rubycritic config lib
coverage:
	COVERAGE=true bundle exec rspec
