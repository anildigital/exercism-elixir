defmodule Bob do
  def hey(input) do
    cond do
      Remark.is_shouting?(input)  -> "Whoa, chill out!"
      Remark.is_question?(input) -> "Sure."
      Remark.is_empty?(input) -> "Fine. Be that way!"     
      true -> "Whatever."
    end
  end
end

defmodule Remark do
  def is_shouting?(text) do
    (String.upcase(text) == text) and (String.downcase(text) != text)
  end

  def is_question?(text) do
    String.ends_with?(text, "?")
  end

  def is_empty?(text) do
    String.strip(text) == ""
  end
end
