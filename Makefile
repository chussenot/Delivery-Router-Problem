console:
	bundle exec pry -r ./stack.rb
bench:
	bundle exec rake bench:measure
measures:
		python script/termgraph.py dat/time.dat
