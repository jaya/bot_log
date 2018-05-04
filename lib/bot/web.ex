defmodule Bot.Web do
  import Plug.Conn
  require Logger

  def init(%{} = options) do
    # initialize options
    Logger.info("Bot.Web initialized, with #{inspect(options)}")
    options
  end

  def call(conn, _opts) do
    Logger.info("CON")
    Bot.Queue.enqueue(conn)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello world")
  end

  def child_spec(queue) do
    Plug.Adapters.Cowboy.child_spec(
      scheme: :http,
      plug: {__MODULE__, %{queue: queue}},
      options: [port: 4001]
    )
  end
end
