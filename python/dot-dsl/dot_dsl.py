NODE, EDGE, ATTR = range(3)


class Node(object):
    def __init__(self, name, attrs={}):
        self.name = name
        self.attrs = attrs

    def __eq__(self, other):
        return self.name == other.name and self.attrs == other.attrs


class Edge(object):
    def __init__(self, src, dst, attrs={}):
        self.src = src
        self.dst = dst
        self.attrs = attrs

    def __eq__(self, other):
        return (self.src == other.src and
                self.dst == other.dst and
                self.attrs == other.attrs)


class Graph(object):
    def __init__(self, data=[]):
        self.nodes = []
        self.edges = []
        self.attrs = {}

        for datum in data:
            tuple_length = len(datum)
            type = tuple_length > 0 and datum[0]
            if tuple_length == 3 and type == NODE:
                _, name, attr = datum
                self.nodes.append(Node(name,attr))
            elif tuple_length == 4 and type == EDGE:
                _, src, dest, attr = datum
                self.edges.append(Edge(src, dest, attr))
            elif tuple_length == 3 and type == ATTR:
                _, key, val = datum
                self.attrs[key] = val
            elif tuple_length > 1:
                raise ValueError("Invalid Graph Tuple")
            else:
                raise TypeError("Invalid Graph Type")


