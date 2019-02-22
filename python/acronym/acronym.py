import re

def abbreviate(words):
    return "".join(
        list(
            map(_first_letter_upper, _split_spaces_and_dashes(words))
        )
    )

def _split_spaces_and_dashes(string):
    return re.sub("-", " ", string).split()

def _first_letter_upper(string):
    without_special_chars = re.sub("\W+|_+", "", string)
    if len(without_special_chars) > 0:
        return without_special_chars[0].upper()
    else:
        return ""
