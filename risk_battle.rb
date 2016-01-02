class RiskBattle
  attr_accessor :attackers,
                :defenders,
                :attack_dice,
                :defend_dice

  def initialize( attackers, defenders, stepwise, silent )
    @silent    = silent
    @stepwise  = stepwise
    @attackers = attackers.to_i || 3
    @defenders = defenders.to_i || 2
  end

  def outcome
    fight_to_death
    print_battle_result unless @silent
    return defenders.zero? ? :conquest : :defended
  end

  def self.test(attackers, defenders)
    test_cases = 100000
    conquests, defences = 0, 0
    test_cases.times do
      battle = self.new(attackers, defenders, false, true)
      if battle.outcome == :conquest
        conquests += 1
      else
        defences += 1
      end
    end
    puts "#{(conquests*100/test_cases).to_f}% conquest rate"

    return {conquests: conquests, defences: defences}
  end

  # =============================================
  private

    def fight_to_death
      attack! while @attackers > 1 && @defenders > 0
    end

    def attack!
      unless @silent
        puts "#{attackers} attacking, #{defenders} defending..."
      end

      roll_dice
      first_comparison
      second_comparison

      if @stepwise
        puts "Enter to continue..."; gets
      end
    end

    def compare_top_dice
      if @defend_dice.max >= @attack_dice.max
        puts "-1 attacker" unless @silent
        @attackers -= 1
      else
        puts "-1 defender" unless @silent
        @defenders -= 1
      end
    end

    def print_battle_result
      puts "Result: #{attackers} attackers, #{defenders} defenders"
      puts "Territory conquered!" if defenders.zero?
      puts "Territory defended!" if attackers == 1
    end

    def first_comparison
      compare_top_dice
      remove_top_dice
    end

    def second_comparison
      return unless defend_dice.count > 0 && attack_dice.count > 0
      compare_top_dice
      remove_top_dice
    end

    def remove_top_dice
      [attack_dice, defend_dice].each do |dice|
        dice.delete_at dice.index(dice.max)
      end
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
        unless @silent
          puts "Attacker rolls #{@attack_dice.sort.reverse}"
          puts "Defender rolls #{@defend_dice.sort.reverse}"
        end
        return nil
      end
      return Array.new(num_dice) { rand(1..6) }
    end
end
