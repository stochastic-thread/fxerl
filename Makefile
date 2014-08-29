all:
			test -d deps || rebar.cmd get-deps
			rebar.cmd compile
			@erl -noshell -pa './deps/jsx/ebin' -pa './ebin' -s fxerl start