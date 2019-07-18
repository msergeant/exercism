def rotate(text, key):
    return ''.join([__rotate_chr(i, key) for i in text])

UPPER_A = ord('A')
UPPER_Z = ord('Z')
LOWER_A = ord('a')
LOWER_Z = ord('z')

def __rotate_chr(char, key):
    char_ord = ord(char)

    if (UPPER_A <= char_ord <= UPPER_Z):
        base = UPPER_A
    elif (LOWER_A <= char_ord <= LOWER_Z):
        base = LOWER_A
    else:
        return char

    shifted = char_ord - base
    return chr((shifted + key) % 26 + base)
