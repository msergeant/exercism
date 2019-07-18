def find_anagrams(word, candidates):
    return [w for w in candidates if __is_anagram(word, w)]

def __is_anagram(w1, w2):
    if len(w1) != len(w2):
        return False

    word1 = w1.lower()
    word2 = w2.lower()
    count1 = {l: word1.count(l) for l in word1}
    count2 = {l: word2.count(l) for l in word2}

    return  word1 != word2 and count1 == count2

