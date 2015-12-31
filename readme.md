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

Example:

```bash
ATTACKING=10 DEFENDING=5 STEPWISE=true ruby risk_resolver.rb
```

