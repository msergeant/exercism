def distance(strand_a, strand_b):
    if strand_a == strand_b:
        return 0
    elif len(strand_a) != len(strand_b):
        raise ValueError("Strings must be same length")
    else:
        total = 0
        for i in range(len(strand_a)):
            if strand_a[i] != strand_b[i]:
                total += 1

        return total

