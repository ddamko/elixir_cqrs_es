# Elixir CQRS with Event Sourcing

## About Elixir and CQRS
Elixir is a new functional language built on the Erlang VM (Beam) which is an industry-proven functional programming language that simplifies writing reliable, concurrent, distributed systems.

CQRS is an architectural pattern that separates commands (which mutate state) from queries (which return values). With CQRS the “read” data store and the “write” data store can be on different severs, can use different storage engines, and can be scaled independently. CQRS is often linked with the Event Sourcing pattern which models state as a series of events (past tense verbs) rather than a single “latest” value. What works for an accountant’s ledger and for Git can work for our “write” store too. Given a series of events we can deal with concurrency and collisions more intelligently than “last guy wins”. We can also define varied service level agreements for commands and queries.

CQRS promotes distribution, concurrency and eventual consistency which is dandy until we attempt to code an implementation with conventional tools like C# or Java. Lucky for us Elixir/Erlang is unconventional in all the right ways. Many of the ideas of CQRS dovetail perfectly with the sweet-spots of Elixir/Erlang.

This is a port of Bryan Hunter's [example](https://github.com/bryanhunter/cqrs-with-erlang/tree/ndc-oslo) in Erlang.

### Try it out.
```
git clone https://github.com/ddamko/elixir_cqrs_es.git

cd elixir_cqrs_es

iex -S mix (This will compile and start up the Elixir shell)

iex(1)> Bank.open
{:ok, #PID<0.146.0>}

iex(2)> Bank.create "Wolfman"
Command Sent
Command Handler: Create Account
Event Store Published Event
:ok
Event Published
Event Handler: Account Created
Account Created

iex(3)> Bank.deposit "Wolfman", 100
Command Sent
Command Handler: Deposit Money
:ok
Event Store Published Event
Event Published
Event Handler: Money Deposited
Money Deposited

iex(4)> Bank.withdraw "Wolfman", 50
Command Sent
Command Handler: Withdraw Money
:ok
50
Event Store Published Event
Event Published
Event Handler: Money Withdrawn
Money Withdrawn

iex(5)> Bank.check_balance "Wolfman"
50

iex(6)> Bank.withdraw "Wolfman", 100
Command Sent
Command Handler: Withdraw Money
-50
:ok
Event Store Published Event
Event Published
Event Handler: Payment Declined
iex(7)> 
10:49:00.200 [info]  Payment declined for Account: "wolfman". Shame, shame!

```


