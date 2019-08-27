defmodule Metex.Worker do

  # 1. Data transformation(result): form URL to HTTP response to parsing that response
  # 2. Case statement: parsed response returns location and the temperature,
  #    otherwise, an error message is returned.
  def temperature_of(location) do
    result =
      url_for(location)
      |> HTTPoison.get()
      |> parse_response

    case result do
      {:ok, temperature} ->
        "#{location}: #{temperature}°C"

      :error ->
        "#{location} not found"
    end
  end

  defp url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey}"
  end

  # matches a successful GET request because we’re matching a response of type HTTPoison.Response
  # and also making sure status_code is 200.
  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body
    |> Jason.decode!()
    |> compute_temperature
  end

  # any response other than a successful one is treated as an error
  defp parse_response(_) do
    :error
  end

  # getting temp nested field from a response and passing
  # through conversion to_celsius function
  defp compute_temperature(response) do
    try do
      temperature =
        response["main"]["temp"]
        |> to_celsius
        |> Float.round(1)

      {:ok, temperature}
    rescue
      _ -> :error
    end
  end

  # from F to C
  defp to_celsius(temperature) do
    temperature - 273.15
  end

  # getting API key from secret.exs
  defp apikey do
    Application.get_env(:metex, :api_key)
  end
end
