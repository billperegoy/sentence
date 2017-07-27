defmodule Word do
  defstruct leading: nil, word: nil, trailing: nil

  @moduledoc """
  Functions to creating and manipulating a Word struct.
  """

  @doc """
  Build a Word struct from a string

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


  @doc """
  Extract a list of raw words without punctuation from a list of Word structs.

  ## Examples

      iex> words =
      ...> [ %Word{leading: "...", word: "word1", trailing: ".."},
      ...>   %Word{leading: "", word: "word2", trailing: ""}
      ...> ]
      iex> Word.raw_words(words)
      ["word1", "word2"]

  """
  def raw_words(words) do
    Enum.map(words, fn elem -> elem.word end)
  end


  @doc """
  Merge a list of Word structs with a raw string list, replacing the words.

  ## Examples

      iex> words =
      ...> [ %Word{leading: "...", word: "word1", trailing: ".."},
      ...>   %Word{leading: "", word: "word2", trailing: ""}
      ...> ]
      iex> replacements = ["new_word1", "new_word2"]
      iex> Word.merge(words, replacements)
      [ %Word{leading: "...", word: "new_word1", trailing: ".."},
        %Word{leading: "", word: "new_word2", trailing: ""}
      ]

  """
  def merge(words, new_words) do
    zipped = Enum.zip(words, new_words)
    Enum.map(zipped, &update_single_word(&1))
  end


  @doc """
  Turn a list of Word structs into a printable string.

  ## Examples

      iex> words =
      ...> [ %Word{leading: "...", word: "word1", trailing: ".."},
      ...>   %Word{leading: "", word: "word2", trailing: ""}
      ...> ]
      iex> Word.list_to_string(words)
      "...word1.. word2"
  """
  def list_to_string(words) do
    Enum.map(words, fn elem -> elem.leading <> elem.word <> elem.trailing end)
      |> Enum.join(" ")
  end


  def update_single_word(item) do
    word = elem(item, 0)
    new_word = elem(item, 1)
    %{word | word: new_word}
  end
end
