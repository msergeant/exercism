def find_anagrams(word, candidates):
    return [w for w in candidates if __is_anagram(word, w)]

def __is_anagram(w1, w2):
    word1 = w1.lower()
    word2 = w2.lower()

    return  word1 != word2 and sorted(word1) == sorted(word2)
