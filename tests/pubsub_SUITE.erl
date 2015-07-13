%%==============================================================================
%% Copyright 2010 Erlang Solutions Ltd.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%% http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%==============================================================================

-module(pubsub_SUITE).
-compile(export_all).

-include_lib("escalus/include/escalus.hrl").
-include_lib("common_test/include/ct.hrl").


%%--------------------------------------------------------------------
%% Suite configuration
%%--------------------------------------------------------------------

all() ->
    [{group, pubsub}].

groups() ->
    [{pubsub,[sequence], [request_to_create_node]}].


suite() ->
    escalus:suite().

%%--------------------------------------------------------------------
%% Init & teardown
%%--------------------------------------------------------------------

init_per_group(_GroupName, Config) ->
    escalus:create_users(Config,{by_name, [alice, bob]}).

end_per_group(_GroupName, Config) ->
    escalus:delete_users(Config,{by_name, [alice, bob]}).

init_per_suite(Config) ->
    escalus:init_per_suite(Config).

end_per_suite(Config) ->
    escalus:end_per_suite(Config).

init_per_testcase(_TestName, Config) ->
    escalus:init_per_testcase(_TestName, Config).

end_per_testcase(_TestName, Config) ->
    escalus:end_per_testcase(_TestName, Config).



%%--------------------------------------------------------------------
%% Tests
%%--------------------------------------------------------------------

messages_story(Config) ->

    
    escalus:story(Config, [1, 1], fun(Alice, Bob) ->
	  
        %% Alice sends a message to Bob
	Sent = escalus_stanza:chat_to(Bob, "HELLLO"), 				  
        %% escalus:send(Alice, escalus_stanza:chat_to(Bob, "OH, HAI!")
        escalus:send(Alice, Sent),
        %% AsXml = exml:to_list(AsXml),
        %% AsXml = escalus:pretty_stanza_list(Sent),
        %% io:format("------ bubu gaga ~p~n ~p~n",[Sent, AsXml]),				  

        %% Bob gets the message
        escalus:assert(is_chat_message, ["HELLLO"], escalus:wait_for_stanza(Bob))
    end).



dupa_test(Config) ->
    escalus:story(Config, [1, 1], fun(Alice,_Bob) ->
        escalus:send(Alice, escalus_stanza:dupa()),
        escalus:assert(is_presence, escalus:wait_for_stanza(Alice))
        end).



request_to_create_node(Config) ->
%%    escalus:send(Alice, escalus_stanza:dupa()).
    bubu.


%%-----------------------------------------------------------------
%% Helpers
%%-----------------------------------------------------------------















