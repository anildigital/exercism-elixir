defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Dict.t) :: map()
  def transform(input) do
    Enum.reduce(input, %{}, fn({key, values}, acc) ->
      values
      |> downcase
      |> do_transform(key)
      |> Map.merge(acc)
    end)
  end
  
  def do_transform(value, key) do
    Enum.reduce(value, %{}, fn(value, acc) -> Map.put(acc, value, key) end)
  end

  defp downcase(v) do
    Enum.map(v, &String.downcase/1)
  end 
end
