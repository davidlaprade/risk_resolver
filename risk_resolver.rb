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
#
# ASSUMPTIONS:
#   * It is always in the defender's best
#     interests to defend with 2 troops if
#     possible
#   * It is always in the attacker's best
#     interests to attack with as many troops
#     as possible
#   * The competing armies will fight to the death

class RiskBattle

  attr_accessor :attackers,
                :defenders,
                :attack_dice,
                :defend_dice

  def initialize( attackers = 1, defenders = 1, stepwise = false)
    @stepwise = stepwise
    @attackers = attackers.to_i
    @defenders = defenders.to_i
    @attack_dice = []
    @defend_dice = []
  end

  def outcome
    while attackers > 1 && defenders > 0
      puts "#{attackers} attacking, #{defenders} defending..."
      faceoff
      if @stepwise
        puts "Enter to continue..."
        gets
      end
    end

    puts "Result: #{attackers} attackers, #{defenders} defenders"
    puts "Territory conquered!" if defenders.zero?
    puts "Territory defended!" if attackers == 1
  end

  # =============================================
  private

    def compare_top_dice
      if @defend_dice.max >= @attack_dice.max
        puts "-1 attacker"
        @attackers -= 1
      else
        puts "-1 defender"
        @defenders -= 1
      end
    end

    def faceoff
      roll_dice

      puts "Attacker rolls #{@attack_dice.sort.reverse.inspect}"
      puts "Defender rolls #{@defend_dice.sort.reverse.inspect}"

      first_round
      second_round
    end

    def first_round
      compare_top_dice
      remove_top_dice
    end

    def second_round
      if defend_dice.count > 0 && attack_dice.count > 0 &&
          @attackers > 1 && @defenders > 0
        compare_top_dice
        remove_top_dice
      end
    end

    def remove_top_dice
      attack_dice.delete_at attack_dice.index(attack_dice.max)
      defend_dice.delete_at defend_dice.index(defend_dice.max)
    end

    def roll_dice( *arg )
      case arg.first
      when :attack
        num_dice = attackers > 3 ? 3 : attackers - 1
      when :defend
        num_dice = defenders >= 2 ? 2 : defenders
      when nil
        @attack_dice = roll_dice :attack
        @defend_dice = roll_dice :defend
        return nil
      end
      return Array.new(num_dice) { rand(1..6) }
    end
end

RiskBattle.new(
  ENV["ATTACKING"],
  ENV["DEFENDING"],
  ENV["STEPWISE"] || false
).outcome
