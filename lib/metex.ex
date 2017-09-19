defmodule Metex do

  def temperature_of(cities) when is_list(cities) do

    coordinator_pid = spawn(Metex.Coordinator, :loop, [[], Enum.count(cities)])

    cities |> Enum.each(fn city ->
      worker_pid = spawn(Metex.Worker, :loop, [])
      send worker_pid, {coordinator_pid, city}
    end)
  end

  def temperature_of(location) when is_binary(location) do

    coordinator_pid = spawn(Metex.Coordinator, :loop, [[], 1])
    worker_pid = spawn(Metex.Worker, :loop, [])
    send worker_pid, {coordinator_pid, location}
  end
end
