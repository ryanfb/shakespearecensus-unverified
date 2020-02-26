all: index.html style.css

index.html: unverified.rb index.haml Gemfile Gemfile.lock shakespearecensus.org
	bundle install && bundle exec ./unverified.rb shakespearecensus.org/copy/*/index.html

shakespearecensus.org:
	wget -m 'https://shakespearecensus.org/'

style.css: | shakespearecensus.org
	cp -v shakespearecensus.org/static/census/style.*.css style.css

clean:
	rm -rfv index.html style.css shakespearecensus.org
