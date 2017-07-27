defmodule Sentence do
  @moduledoc """
  Sentence is a code kata I used to teach myself some Elixir.
  """


  @doc """
  Reverse a sentence while keeping punctuation in same relative place

  ## Examples

      iex> Sentence.reverse("This is a test")
      "test a is This"

      iex> Sentence.reverse("This is a test.")
      "test a is This."

      iex> Sentence.reverse("This... is a test.")
      "test... a is This."

      iex> Sentence.reverse("This... ...is a test.")
      "test... ...a is This."

  """
  def reverse(string) do
    words = get_words(string)
    reversed_word_list = reversed_words(words)

    Word.merge(words, reversed_word_list) 
      |> Word.list_to_string
  end


  @doc """
  Turn a string into a list of Word structs.

  ## Examples

      iex> Sentence.get_words("This is a test")
      [ %Word{leading: "", word: "This", trailing: ""},
        %Word{leading: "", word: "is", trailing: ""},
        %Word{leading: "", word: "a", trailing: ""},
        %Word{leading: "", word: "test", trailing: ""}
      ]

      iex> Sentence.get_words("This... is a test.")
      [ %Word{leading: "", word: "This", trailing: "..."},
        %Word{leading: "", word: "is", trailing: ""},
        %Word{leading: "", word: "a", trailing: ""},
        %Word{leading: "", word: "test", trailing: "."}
      ]

  """
  def get_words(string) do
    string 
      |> String.split(~r/\s+/)
      |> Enum.map(&Word.from_string(&1))
  end


  @doc """
  Extract the raw list of words from a list of Word structs and reverse it.

  ## Examples

      iex> words =
      ...> [ %Word{leading: "", word: "This", trailing: "..."},
      ...>   %Word{leading: "", word: "is", trailing: ""},
      ...>   %Word{leading: "", word: "a", trailing: ""},
      ...>   %Word{leading: "", word: "test", trailing: "."}
      ...> ]
      iex> Sentence.reversed_words(words)
      ["test", "a", "is", "This"]

  """
  def reversed_words(words) do
    Word.raw_words(words)
      |> Enum.reverse
  end
end
