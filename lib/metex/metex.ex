defmodule Metex.Metex do
  # This actor must keep track of how many messages are expected. In other
  # words, the actor must keep state.

  #             metex.ex(keeps state)
  #            /        \
  #   worker.ex          coordinator.ex

  cities =
  IO.gets("File to count the lines, words or characters from: \n")
  |> String.trim()

  def temperature_of(cities) do
    # The loop function of the coordinator process expects
    # two arguments: the current collected results and the total expected number of
    # results. Therefore, when you create the coordinator, you initialize it with an
    # empty result list and the number of cities
    #  ||
    #  \/
    coordinator_pid = spawn(Metex.Coordinator, :loop, [[], Enum.count(cities)])

    # the coordinator process is waiting for messages from the worker.
    # Given a list of cities, you iterate through each city, create a worker,
    # and then send the worker a message containing the coordinator pid and the city:
    #  ||
    #  \/
    cities
    |> Enum.each(fn city ->
      worker_pid = spawn(Metex.Worker, :loop, [])
      send(worker_pid, {coordinator_pid, city})
    end)
  end
end
