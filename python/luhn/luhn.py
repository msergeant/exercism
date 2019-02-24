import re

class Luhn(object):
    def __init__(self, card_num):
        self.card_num = card_num.replace(" ", "")
        self.sorted_card_num = list(self.card_num)
        self.sorted_card_num.reverse()

    def is_valid(self):
        if len(self.sorted_card_num) <= 1 or re.search("[^\d]", self.card_num):
            return False

        modified_digits = [
            self._digit_lambda(i, x) for i,x in enumerate(self.sorted_card_num)
        ]

        return sum(modified_digits) % 10 == 0

    def _digit_lambda(self, idx, num):
        num = int(num)
        if idx % 2 != 0:
            return self._digit_doubler(num)
        else:
            return num

    def _digit_doubler(self, num):
        if(num >= 5):
            return 2 * num - 9
        else:
            return 2 * num
