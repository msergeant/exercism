import re

def hey(phrase):
    stripped = phrase.strip()
    if not stripped:
        return "Fine. Be that way!"

    question = __is_question(stripped)
    shouting = __is_shouting(stripped)

    if question and shouting:
        return "Calm down, I know what I'm doing!"
    elif question:
        return "Sure."
    elif shouting:
        return "Whoa, chill out!"
    else:
        return "Whatever."

def __is_shouting(phrase):
    return (bool(re.match(r'[A-Z\s\W\d]+\Z', phrase)) and
            bool(re.search(r'[A-Z]', phrase)))

def __is_question(phrase):
    return bool(re.match(r'.*\?\Z', phrase))
