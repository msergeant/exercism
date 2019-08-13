def reverse(text):
    rev_text = []
    for i in range(len(text)):
        rev_text.insert(0, text[i])
    return ''.join(rev_text)
