defmodule Publisher do
use GenServer

  # Server
  def start do
    {:ok, subscription_manager} = SubscriptionManager.start
    GenServer.start(Publisher, subscription_manager)
  end

  def handle_cast({:subscribe, name, pid}, subscription_manager) do
    SubscriptionManager.put(subscription_manager, name, pid)
    {:noreply, subscription_manager}
  end

  def handle_cast({:unsubscribe, name}, subscription_manager) do
    SubscriptionManager.delete(subscription_manager, name)
    {:noreply, subscription_manager}
  end

  def handle_cast({:notify, message}, subscription_manager) do
    SubscriptionManager.get_all(subscription_manager) |>
    Enum.map(fn {key, value} -> GenEvent.notify(value, message) end)
    {:noreply, subscription_manager}
  end

# Client
  def subscribe(server, name, pid) do
    GenServer.cast(server, {:subscribe, name, pid})
  end

  def unsubscribe(server, name) do
    GenServer.cast(server, {:unsubscribe, name})
  end

  def notify(server, message) do
     GenServer.cast(server, {:notify, message})
     IO.puts "I have published: '#{message}'"
  end

end
