from functools import reduce
from re import sub

def word_count(phrase):
    cleaned_phrase = phrase.lower()
    cleaned_phrase = sub("' | '|\.|[^'\w ]|_", " ", cleaned_phrase)
    return reduce(_add_word, cleaned_phrase.split(), dict())

def _add_word(counts, word):
    counts.setdefault(word, 0)
    counts[word] += 1
    return counts
