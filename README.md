# PubSubEx
This project is a PoC which tries to demonstrate how easy is to create a
distributed system using [Elixir][elixirlang]. This example is a Publisher-Subscriber
system.

## Execution with IEX
* Node 1
```bash
$ iex --sname node1 --cookie pubsub -S mix
iex(node1@host)> {:ok, manager} = Publisher.start
iex(node1@host)> :global.register_name('manager', manager)
```

* Node 2
```bash
$ iex --sname node2 --cookie pubsub -S mix
iex(node2@host)> Node.connect :'node1@host'
iex(node2@host)> manager = :global.whereis_name('manager')
iex(node2@host)> {:ok, subscriber} = Subscriber.start
iex(node2@host)> Publisher.subscribe(manager, 'subs_node2', subscriber)
```

* Node 3
```bash
$ iex --sname node3 --cookie pubsub -S mix
iex(node3@host)> Node.connect :'node1@host'
iex(node3@host)> manager = :global.whereis_name('manager')
iex(node3@host)> {:ok, subscriber} = Subscriber.start
iex(node3@host)> Publisher.subscribe(manager, 'subs_node3', subscriber)
```

* How to publish a message
```bash
iex> Publisher.notify(manager, "Hello !!")
```




[elixirlang]: <http://elixir-lang.org/>
