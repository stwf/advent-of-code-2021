defmodule DayTwo do
  def run(starter) do
    answer =
      initial_data()
      |> massage()
      |> Enum.reduce(starter, &handle_command(&1, &2))

    IO.inspect(elem(answer, 0) * elem(answer, 1))
  end

  defp handle_command({:down, amount}, {depth, length}), do: {depth + amount, length}

  defp handle_command({:up, amount}, {depth, length}), do: {depth - amount, length}

  defp handle_command({:forward, amount}, {depth, length}), do: {depth, length + amount}

  defp handle_command({:down, amount}, {depth, length, aim}), do: {depth, length, aim + amount}

  defp handle_command({:up, amount}, {depth, length, aim}), do: {depth, length, aim - amount}

  defp handle_command({:forward, amount}, {depth, length, aim}), do: {depth + (amount * aim), length + amount, aim}

  defp initial_data(), do: File.read!("data.txt")

  defp massage(data) do
    data
    |> String.split()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [d, v] -> {String.to_existing_atom(d), String.to_integer(v)} end)
  end
end

DayTwo.run({0, 0})
DayTwo.run({0, 0, 0})
