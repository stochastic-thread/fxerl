all:
			test -d deps || rebar get-deps
			rebar compile
			@erl -noshell -pa './deps/jsx/ebin' -pa './ebin' -s fxerl start