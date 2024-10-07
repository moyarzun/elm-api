require 'rails_helper'

RSpec.describe Match, type: :model do
  it 'should have a default max_players of 2' do
    match = Match.new
    expect(match.max_players).to eq(2)
  end

  it 'should not allow more players than max_players' do
    match = Match.create!(max_players: 2)
    player1 = Player.create!(name: 'Player 1')
    player2 = Player.create!(name: 'Player 2')
    player3 = Player.create!(name: 'Player 3')

    match.players << player1
    match.players << player2

    expect do
      match.players << player3
    end.to raise_error(ActiveRecord::RecordInvalid,
                       'Validation failed: Match already has the maximum number of players (2)')
  end

  it 'should allow setting a score for each player in a match' do
    match = Match.create!(max_players: 2)
    player1 = Player.create!(name: 'Player 1')
    player2 = Player.create!(name: 'Player 2')

    player_match1 = PlayerMatch.create!(player: player1, match:, score: 10)
    player_match2 = PlayerMatch.create!(player: player2, match:, score: 20)

    expect(player_match1.score).to eq(10)
    expect(player_match2.score).to eq(20)
  end
end
