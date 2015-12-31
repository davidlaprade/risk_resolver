### About
This program speeds up [RISK](https://en.wikipedia.org/wiki/Risk_(game))
play times by resolving large battles without needing to
repeatedly roll any dice.

It makes the following assumptions:
  * It is always in the defender's best
    interest to defend with as many troops
    as possible
  * It is always in the attacker's best
    interest to attack with as many troops
    as possible
  * Competing armies fight to the death


### To Use
Simply run the script passing in the following ENV variables:

| Variable | Meaning | Default Value | Optional? |
|--------------|---------|---------------|-----------|
| ATTACKING | number of pieces in attacking colony | 3 | false |
| DEFENDING | number of pieces in defending colony | 2 | false |
| STEPWISE | whether to step through the process one "roll" at a time | false | true |
| SILENT | whether to print the results to STDOUT | false | true |

Example:

```bash
$ ATTACKING=8 DEFENDING=14 ruby risk_resolver.rb

8 attacking, 14 defending...
Attacker rolls [6, 5, 4]
Defender rolls [4, 1]
-1 defender
-1 defender
8 attacking, 12 defending...
Attacker rolls [4, 4, 4]
Defender rolls [3, 1]
-1 defender
-1 defender
8 attacking, 10 defending...
Attacker rolls [6, 2, 1]
Defender rolls [5, 2]
-1 defender
-1 attacker
7 attacking, 9 defending...
Attacker rolls [5, 1, 1]
Defender rolls [6, 1]
-1 attacker
-1 attacker
5 attacking, 9 defending...
Attacker rolls [6, 4, 3]
Defender rolls [6, 4]
-1 attacker
-1 attacker
3 attacking, 9 defending...
Attacker rolls [3, 1]
Defender rolls [3, 2]
-1 attacker
-1 attacker
Result: 1 attackers, 9 defenders
Territory defended!
```

