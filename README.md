# poker_challenge

## Problem Source
https://projecteuler.net/problem=54

## Set Up
- Written in Ruby 5.2.7 and tested using RSpec
- To run Fork Clone and run `ruby lib/poker_runner.rb`
- To run the test suite run  `rspec spec/game_spec.rb`

## Approach 
Designed the problem to work with two classes. A Game class and a HandGenerator class. The HandGenerator class is resposible for reading the txt file
and parsing it into sets of 10 strings representing the ten cards of that game. The Game class spits those ten cards into player one and player two 
hands and implements game logic to determine who has the better hand. This process is repeated for all 1000 games to determine how may hands player
one wins. 



