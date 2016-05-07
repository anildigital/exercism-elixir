defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: _count(l, 0)
  def _count([], acc), do: acc
  def _count([_item|rest], acc), do: _count(rest, acc + 1)

  @spec reverse(list) :: list
  def reverse(l), do: _reverse(l, [])
  defp _reverse([], acc), do: acc
  defp _reverse([item|rest], acc), do: _reverse(rest,  [item | acc])
  
  @spec map(list, (any -> any)) :: list
  def map(l, f), do:  _map(l, f, [])
  defp _map([], _f, acc), do: reverse(acc)
  defp _map([item|rest], f, acc), do: _map(rest, f,  [f.(item) | acc ] )

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    acc = []
    _filter(l, f, acc)
  end
  defp _filter([], _f, acc), do: reverse(acc)
  defp _filter([item|rest], f, acc) do
    if (f.(item)) do
      result = [item | acc ]
    else
      result = acc
    end
    _filter(rest, f, result)
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f), do: _reduce(l, acc, f)
  def _reduce([], acc, _f), do: acc
  def _reduce([item|rest], acc, f), do: _reduce(rest, f.(item, acc), f)

  @spec append(list, list) :: list
  def append(a, b), do: _append(reverse(a), b)
  defp _append([], acc), do: acc
  defp _append([item|rest], acc), do: _append(rest, [item | acc])
  
  # @spec concat([[any]]) :: [any]
  # def concat(ll), do:  _concat(ll, [])
  # def _concat([], acc), do: acc
  # def _concat([item|rest], acc) do
  #   _concat(rest, append(acc, item))
  # end

  @spec concat([[any]]) :: [any]
  def concat(ll), do: reverse(ll) |> reduce([], &(append(&1, &2)))
end
