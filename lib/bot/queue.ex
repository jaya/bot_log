defmodule Bot.Queue do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, {}, name: __MODULE__)
  end

  def init(_) do
    {:ok, :queue.new()}
  end

  def dequeue() do
    GenServer.call(__MODULE__, {:dequeue})
  end

  def enqueue(x) do
    GenServer.cast(__MODULE__, {:enqueue, x})
  end

  def handle_cast({:enqueue, x}, queue) do
    Logger.info("enqueued")
    {:noreply, :queue.in(x, queue)}
  end

  def handle_call({:dequeue}, _from, queue) do
    {{:value, x}, new_queue} = :queue.out(queue)
    {:reply, x, new_queue}
  end
end
