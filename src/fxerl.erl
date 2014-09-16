-module(fxerl).
-import(jsx, [decode/1]).
-export([start/0, stop/0]).

print_pairs(_, []) ->
	io:format("All pairs printed!~n");

print_pairs(Rates, Keys) ->
	[Hk|Tk] = Keys,
	io:format("1 dollar is ~p ~p ~n",[proplists:get_value(Hk, Rates), binary_to_list(Hk)]),
	io:format("1 ~p is ~p dollars ~n ~n",[binary_to_list(Hk), 1/proplists:get_value(Hk, Rates)]),
	print_pairs(Rates, Tk).

start() -> 
	URL = "http://openexchangerates.org/api/latest.json?app_id=2bcca613e8034f2cbd416a027258d599",
	inets:start(),
	{ok, Req} = httpc:request(URL),
	{_, _, C} = Req,
	D = list_to_binary(C),
	E = jsx:decode(D),
	Rates = proplists:get_value(<<"rates">>, E),
	% GBP = proplists:get_value(<<"GBP">>, Rates),
	% EUR = proplists:get_value(<<"EUR">>, Rates),
	% JPY = proplists:get_value(<<"JPY">>, Rates),
	% BTC = proplists:get_value(<<"BTC">>, Rates),
	Keys = proplists:get_keys(Rates),
	print_pairs(Rates, Keys).
	%io:format("~p~n",[Keys]).
	% io:format("1 dollar is ~p euro ~n",[EUR]),
	% io:format("1 dollar is ~p pound ~n",[GBP]),
	% io:format("1 dollar is ~p yen ~n",[JPY]).

stop() -> init:stop().