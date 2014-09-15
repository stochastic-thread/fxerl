-module(currencies).
-import(jsx, [decode/1]).
-export([start/0, stop/0]).

start() -> 
	URL = "http://openexchangerates.org/api/latest.json?app_id=2bcca613e8034f2cbd416a027258d599",
	inets:start(),
	{ok, Req} = httpc:request(URL),
	{_, _, C} = Req,
	D = list_to_binary(C),
	E = jsx:decode(D),
	Rates = proplists:get_value(<<"rates">>, E),
	GBP = proplists:get_value(<<"GBP">>, Rates),
	EUR = proplists:get_value(<<"EUR">>, Rates),
	JPY = proplists:get_value(<<"JPY">>, Rates),
	io:format("1 dollar is ~p euro ~n",[EUR]),
	io:format("1 dollar is ~p pound ~n",[GBP]),
	io:format("1 dollar is ~p yen ~n",[JPY]).

stop() -> init:stop().