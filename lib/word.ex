defmodule Word do
  defstruct leading: nil, word: nil, trailing: nil
  @moduledoc """
  Documentation for Word.
  """

  @doc """
  Build Word from String 

  ## Examples

      iex> Word.from_string("Hello")
      %Word{leading: "", word: "Hello", trailing: ""}

      iex> Word.from_string("...Hello")
      %Word{leading: "...", word: "Hello", trailing: ""}

      iex> Word.from_string("Hello...")
      %Word{leading: "", word: "Hello", trailing: "..."}

      iex> Word.from_string("...")
      %Word{leading: "...", word: "", trailing: ""}

  """
  def from_string(string) do
    %{"leading" => leading, "word" => word, "trailing" => trailing} =
      Regex.named_captures(~r/(?<leading>[^a-zA-Z]*)(?<word>[a-zA-Z]*)(?<trailing>[^a-zA-Z]*)/, string)
    %Word{leading: leading, word: word, trailing: trailing}
  end

  def raw_words(words) do
    Enum.map(words, fn elem -> elem.word end)
  end

  def merge(words, new_words) do
    zipped = Enum.zip(words, new_words)
    Enum.map(zipped, &update_single_word(&1))
  end

  def update_single_word(item) do
    word = elem(item, 0)
    new_word = elem(item, 1)
    %{word | word: new_word}
  end

  def list_to_string(words) do
    Enum.map(words, fn elem -> elem.leading <> elem.word <> elem.trailing end)
      |> Enum.join(" ")
  end
end
