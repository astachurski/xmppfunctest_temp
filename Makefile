.PHONY: all test console compile
all: qik

qik:
	erl -noinput -sname test -setcookie ejabberd \
		-pa `pwd`/tests \
		    `pwd`/ebin \
			`pwd`/deps/*/ebin \
		$(ADD_OPTS) \
		-s run_common_test main test=quick spec=pubsub.spec

test_clean: get-deps
	rm -rf tests/*.beam
	make test

pubsubtest: prepare
	erl -noinput -sname test -setcookie ejabberd \
		-pa `pwd`/tests \
		    `pwd`/ebin \
			`pwd`/deps/*/ebin \
		$(ADD_OPTS) \
		-s run_common_test main test=quick spec=pubsub.spec

prepare: compile
	erlc -Ideps/exml/include \
		 run_common_test.erl
	mkdir -p ct_report

compile: get-deps
	./rebar compile

get-deps: rebar
	./rebar get-deps

clean: rebar
	rm -rf tests/*.beam
	./rebar clean

rebar:
	wget http://cloud.github.com/downloads/basho/rebar/rebar
	chmod u+x rebar
