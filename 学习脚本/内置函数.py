'''
print(all([0,-3]))
print(any([0,-3]))
print(bool(1))
print(bin(4))

a = bytes("abcde",encoding="utf-8")
b = bytearray("abcde",encoding="utf-8")
#print(a.capitalize(),a)
print( b[1] )
b[1] = 50
print(b)
'''

# print(lambda n:print(n))
# res = filter(lambda n:n>5,range(10))
# for i in res:
#     print(i)

# a = frozenset([1,4,444,234,4234,560])
# print(type(a))
# print(globals())


def test():
    local_var = 333
    print(locals())
test()

