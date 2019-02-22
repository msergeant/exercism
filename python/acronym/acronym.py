def abbreviate(words):
    without_special_chars = words.replace("-", " ")
    without_special_chars = without_special_chars.replace("_", " ")
    return "".join(
        list(
            map(lambda x: x[0].upper(), without_special_chars.split())
        )
    )
