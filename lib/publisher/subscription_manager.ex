defmodule SubscriptionManager do

  def start_link do
    Agent.start_link(fn -> %{} end)
  end

  def start do
    Agent.start(fn -> %{} end)
  end

  def get_all(agent) do
    Agent.get(agent, fn x -> x end)
  end

  def get(agent, key) do
    Agent.get(agent, fn x -> Map.get(x, key) end)
  end

  def put(agent, key, value) do
    Agent.update(agent, fn x -> Map.put(x, key, value) end)
  end

  def delete(agent, key) do
    Agent.get_and_update(agent, fn x -> Map.pop(x, key) end)
  end

end
