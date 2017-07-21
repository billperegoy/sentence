defmodule Sentence do
  @moduledoc """
  Documentation for Sentence.
  """

  @doc """
  Reverse Keeping Punctuation

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

  def get_words(string) do
    string 
      |> String.split(~r/\s+/)
      |> Enum.map(fn word -> Word.from_string(word) end)
  end

  def reversed_words(words) do
    Word.raw_words(words)
      |> Enum.reverse
  end
end
