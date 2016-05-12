defmodule Subscriber do
use GenEvent

  def start do
    {:ok, pid} = GenEvent.start([])
    GenEvent.add_handler(pid, Subscriber, [])
    {:ok, pid}
  end

  def handle_event(message, state) do
    IO.puts "I have received: '#{message}'"
    {:ok, state}
  end
end
