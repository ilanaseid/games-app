require 'spec_helper'

describe GameType do
subject(:game_types) {GameType.new({
  name: "Tic-tac-toe",
  rules: 'these are the rules'
  })}

it { should validate_presence_of(:name) }
it { should validate_presence_of(:rules) }

end
