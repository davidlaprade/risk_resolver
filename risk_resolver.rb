##############################################
# ----------- INSTRUCTIONS -------------------
##############################################
# This program speeds up RISK play times by
# resolving large battles without needing to
# repeatedly roll any dice.
#
# Simply run the script passing in two ENV
# variables:
#   ATTACKING = number of attacking pieces
#   DEFENDING = number of defending pieces
#
# Example: `ATTACKING=10 DEFENDING=5 ruby risk_resolver.rb`


class RiskBattle

  attr_accessor :attackers,
                :defenders

  def initialize( attackers = 1, defenders = 1 )
    @attackers = attackers
    @defenders = defenders
  end

  def resolve

  end


end
