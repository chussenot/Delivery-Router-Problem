console:
	bundle exec pry -r ./stack.rb
bench:
	bundle exec rake bench:measure
measures:
	script/termgraph dat/time.dat
watch:
	script/watch
