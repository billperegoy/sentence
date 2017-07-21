# Sentence

## Overview
Elixir code to take a string and reverse it while keeping punctuation in the
same relative word position.

I tried to take a functional approach as much as possible. This is the basic
pipeline I used to process the data.

1. Convert the string to a list of words with embedded punctuation. I did this by
   converting each raw string into a %Word{} struct that stored the raw word along
    with any leading and trailing punctuation.

2. I then extracted a raw list of strings (ignoring punctuation) and reversed it.

3. I then merged the raw reversed list into the list of word structures. 

4. I finally converted this list of word structs back into a string restoring
   the punctuation. 

## Testing
I used Elixir doctest to write tests for the top-level function as well as one
other function that I needed help debugging. Normally I would write more
complete tests for all public functions, but given the nature of this exercise I
didn't complete this task.

You can find these tests in sentence.ex and word.ex.

## Limitations
1. The definition of punctuation is not clear. I defined anything as not a
   letter as lowercase for this example but clearly this would need to be
   clarified for real code.

2. Function names could probably be improved but given that I did this in a
   short period of time, I didn't go back and completely refactor.

