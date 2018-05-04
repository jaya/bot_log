defmodule Bot.WebTest do
  use ExUnit.Case
  require Logger
  import ExUnit.CaptureLog
  doctest Bot.Web
  alias Plug.Adapters.Cowboy
  import Plug.Test

  test "greets the world" do
    # {:ok, _} = Cowboy.http(Bot.Web, %{}, port: 4040)
    # {:ok, queue} = Bot.Queue.start_link()

    queue = Process.whereis(Bot.Queue)

    assert capture_log(fn ->
             conn(:get, "/", "")
             |> Bot.Web.call(%{queue: queue})
           end) =~ "enqueued"
  end
end
