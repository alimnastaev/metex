defmodule Metex.Coordinator do
  def loop(results \\ [], results_expected) do
    receive do
      {:ok, result} ->
        # add result to current list of results
        new_results = [result | results]

        # check if all results have been collected
        if results_expected == Enum.count(new_results) do
          # sends the coordinator the exit message
          send(self, :exit)
        end

        # loops with new results (results_expected remains unchanged)
        loop(new_results, results_expected)

      :exit ->
        IO.puts(results |> Enum.sort() |> Enum.join(", "))

      _ ->
        loop(results, results_expected)
    end
  end
end
