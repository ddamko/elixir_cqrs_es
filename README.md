# Elixir CQRS Eventstore

This is a port of Bryan Hunter's [example](https://github.com/bryanhunter/cqrs-with-erlang/tree/ndc-oslo) in Erlang.

### Try it out.
```
cd /elixir_cqrs_es

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

```


