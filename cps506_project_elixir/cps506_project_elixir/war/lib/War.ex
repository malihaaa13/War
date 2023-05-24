defmodule War do
  @moduledoc """
    Documentation for `War`.
  """

  @doc """
    Function stub for deal/1 is given below. Feel free to add 
    as many additional helper functions as you want. 

    The tests for the deal function can be found in test/war_test.exs. 
    You can add your five test cases to this file.

    Run the tester by executing 'mix test' from the war directory 
    (the one containing mix.exs)
  """
  def deal(shuf) do
    shuf = Enum.map(shuf, fn card -> if (card == 1), do: 14, else: card end)
    player1 = distributeShuf(shuf, [])
    player2 = distributeShuf((tl shuf), [])
    shuf = play(player1, player2)
    shuf = Enum.map(shuf, fn card -> if (card == 14), do: 1, else: card end)
  end 
  
  
  def distributeShuf([], player), do: player

  def distributeShuf([card], player), do: [card | player]

  def distributeShuf([card1, card2 | rest], player), do: distributeShuf(rest, [card1 | player])

  def play(player1, []), do: player1
  def play([], player2), do: player2

  def play(player1, player2) do
    [hd1 | tl_p1] = player1
    [hd2 | tl_p2] = player2

    card1 = hd1
    card2 = hd2
    player1_rest = tl_p1
    player2_rest = tl_p2

    cond do 
      card1 > card2 -> play(player1_rest ++ [card1, card2], player2_rest)
      card1 < card2 -> play(player1_rest, player2_rest ++ [card2, card1])
      card1 == card2 -> playWar(player1_rest, player2_rest, [card1] ++ [card2])
    end

  end

  def playWar([], p2, [first | rest]), do: p2 ++ [first | rest]
  def playWar(p1, [], [first | rest]), do: p1 ++ [first | rest]
  
  
  def playWar([x], p2 , [first | rest]) do
    [hdx | tlx] = p2
    temp = [first | rest] ++ [x]
    temp = Enum.sort(temp, fn x, y -> x > y end)

    p2 ++ temp 
  end

  def playWar(p1, [y], [first | rest]) do
    [hdy | tly] = p1
    temp = [first | rest] ++ [y]
    temp = Enum.sort(temp, fn x, y -> x > y end)

    p1 ++ temp 
  end
  
  def playWar([a, b], p2, [first | rest]) do
    [hda | tla] = p2
    temp = [first | rest] ++ [a, b, hda]
    temp = Enum.sort(temp, fn x, y -> x > y end)

    p2 ++ temp
  end

  def playWar(p1, [c, d], [first | rest]) do
    [hdc | tlc] = p1
    temp = [first | rest] ++ [c, d, hdc]
    temp = Enum.sort(temp, fn x, y -> x > y end)

    p1 ++ temp
  end 

  def playWar(p1, p2, [first | rest]) do
    [a, b | p1_rest] = p1
    [c, d | p2_rest] = p2
    faceDown1 = a
    faceUp1 = b
    faceDown2 = c
    faceUp2 = d
    temp = [first | rest] ++ [faceDown1, faceUp1, faceDown2, faceUp2]
    temp = Enum.sort(temp, fn x, y -> x > y end )
    cond do
      faceUp1 > faceUp2 -> play(p1_rest ++ temp, p2_rest)
      faceUp1 < faceUp2 -> play(p1_rest, p2_rest ++ temp)
      faceUp1 == faceUp2 -> playWar(p1_rest, p2_rest, temp)
    end
  end
end