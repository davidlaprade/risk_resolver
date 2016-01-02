$LOAD_PATH << '.'
require 'risk_battle'

RiskBattle.new(
  ENV["ATTACKING"],
  ENV["DEFENDING"],
  ENV["STEPWISE"],
  ENV["SILENT"]
).outcome
