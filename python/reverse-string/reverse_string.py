def reverse(text):
    rev_text = []
    for ch in text:
        rev_text.insert(0, ch)
    return ''.join(rev_text)
