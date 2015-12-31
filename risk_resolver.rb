class RiskBattle
  attr_accessor :attackers,
                :defenders,
                :attack_dice,
                :defend_dice

  def initialize( attackers = 3, defenders = 2, stepwise = false)
    @stepwise = stepwise
    @attackers = attackers.to_i
    @defenders = defenders.to_i
  end

  def outcome
    attack! while attackers > 1 && defenders > 0
    output_result
  end

  # =============================================
  private

    def attack!
      puts "#{attackers} attacking, #{defenders} defending..."

      roll_dice

      puts "Attacker rolls #{@attack_dice.sort.reverse.inspect}"
      puts "Defender rolls #{@defend_dice.sort.reverse.inspect}"

      first_comparison
      second_comparison

      if @stepwise
        puts "Enter to continue..."
        gets
      end
    end

    def compare_top_dice
      if @defend_dice.max >= @attack_dice.max
        puts "-1 attacker"
        @attackers -= 1
      else
        puts "-1 defender"
        @defenders -= 1
      end
    end

    def output_result
      puts "Result: #{attackers} attackers, #{defenders} defenders"
      puts "Territory conquered!" if defenders.zero?
      puts "Territory defended!" if attackers == 1
    end

    def first_comparison
      compare_top_dice
      remove_top_dice
    end

    def second_comparison
      if defend_dice.count > 0 && attack_dice.count > 0 &&
          @attackers > 1 && @defenders > 0
        first_comparison
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
        num_dice = defenders > 1 ? 2 : defenders
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
  ENV["STEPWISE"]
).outcome
