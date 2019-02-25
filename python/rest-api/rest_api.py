import json

class RestAPI(object):
    def __init__(self, database=None):
        self.database = database

    def get(self, url, payload=None):
        if payload == None:
            return json.dumps(self.database)

        json_payload = json.loads(payload)
        filtered = self.database
        if json_payload['users']:
            filtered = { 'users': list(
                filter(
                    lambda x: x['name'] in json_payload['users'], filtered['users']
                )
            )}

        return json.dumps(filtered)

    def post(self, url, payload=None):
        json_payload = json.loads(payload)
        if url == '/add':
            user = self._new_user(json_payload['user'])
            self.database['users'].append(user)
            return json.dumps(user)
        elif url == '/iou':
            return json.dumps(self._do_iou(json_payload))

    def _new_user(self, name):
        return {
            'name': name,
            'owes': {},
            'owed_by': {},
            'balance': 0
        }

    def _do_iou(self, vals):
        lender = next(
            (x for x in self.database['users'] if x['name'] == vals['lender']),
            None
        )

        borrower = next(
            (x for x in self.database['users'] if x['name'] == vals['borrower']),
            None
        )
        amount = vals['amount']


        if borrower['name'] in lender['owes'].keys() and lender['owes'][borrower['name']] > 0:
            lender['owes'][borrower['name']] -= amount
            borrower['owed_by'][lender['name']] -= amount
            self._correct_negatives(lender, borrower['name'])
            self._correct_negatives(borrower, lender['name'])
        else:
            lender['owed_by'].setdefault(borrower['name'], 0)
            lender['owed_by'][borrower['name']] += amount

            borrower['owes'].setdefault(lender['name'], 0)
            borrower['owes'][lender['name']] += amount

        lender['balance'] += amount
        borrower['balance'] -= amount

        users_involved = [lender, borrower]
        users_involved.sort(key=lambda x: x['name'])

        return {'users': users_involved}

    def _correct_negatives(self, user, name):
        if name in user['owes'].keys() and user['owes'][name] < 0:
            user['owed_by'][name] = -user['owes'][name]
            user['owes'].pop(name)
        elif name in user['owed_by'].keys() and user['owed_by'][name] < 0:
            user['owes'][name] = -user['owed_by'][name]
            user['owed_by'].pop(name)



