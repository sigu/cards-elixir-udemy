defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards
  """

  @doc """
  Returns a list of strings representing a deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides the deck into a hand and remainder with the `hand_size` being the
  number of cards we wish to have in our hands.

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _message} -> 'There was a problem loading the file'
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck |> Cards.shuffle |> Cards.deal(hand_size)
  end

end
