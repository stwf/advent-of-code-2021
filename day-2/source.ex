defmodule DayTwo do
  def run(starter) do
    initial_data()
    |> massage()
    |> Enum.reduce(starter, &handle_command(&1, &2))
    |> calculate_totals()
  end

  defp calculate_totals(answer), do: elem(answer, 0) * elem(answer, 1)

  defp handle_command({:down, amount}, {depth, length}), do: {depth + amount, length}

  defp handle_command({:up, amount}, {depth, length}), do: {depth - amount, length}

  defp handle_command({:forward, amount}, {depth, length}), do: {depth, length + amount}

  defp handle_command({:down, amount}, {depth, length, aim}), do: {depth, length, aim + amount}

  defp handle_command({:up, amount}, {depth, length, aim}), do: {depth, length, aim - amount}

  defp handle_command({:forward, amount}, {depth, length, aim}),
    do: {depth + amount * aim, length + amount, aim}

  defp initial_data(), do: File.read!("day-2/data.txt")

  defp massage(data) do
    data
    |> String.split()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [d, v] -> {String.to_existing_atom(d), String.to_integer(v)} end)
  end
end

DayTwo.run({0, 0}) |> IO.inspect()
DayTwo.run({0, 0, 0}) |> IO.inspect()
