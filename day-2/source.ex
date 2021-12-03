defmodule DayTwo do
  def part_a, do: run({0, 0})
  def part_b, do: run({0, 0, 0})

  defp run(starter) do
    initial_data()
    |> massage()
    |> Enum.reduce(starter, &handle_command(&1, &2))
    |> calculate_totals()
  end

  defp initial_data(), do: File.read!("day-2/data.txt")

  defp massage(data) do
    data
    |> String.split()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [d, v] -> {String.to_existing_atom(d), String.to_integer(v)} end)
  end

  defp handle_command({:down, amount}, {depth, length}), do: {depth + amount, length}

  defp handle_command({:up, amount}, {depth, length}), do: {depth - amount, length}

  defp handle_command({:forward, amount}, {depth, length}), do: {depth, length + amount}

  defp handle_command({:down, amount}, {depth, length, aim}), do: {depth, length, aim + amount}

  defp handle_command({:up, amount}, {depth, length, aim}), do: {depth, length, aim - amount}

  defp handle_command({:forward, amount}, {depth, length, aim}),
    do: {depth + amount * aim, length + amount, aim}

  defp calculate_totals(answer), do: elem(answer, 0) * elem(answer, 1)
end

DayTwo.part_a() |> IO.inspect()
DayTwo.part_b() |> IO.inspect()
