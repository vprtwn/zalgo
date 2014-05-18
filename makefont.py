# -*- coding: utf-8 -*-
import plistlib

circle = "ⒶⒷⒸⒹⒺⒻⒽⒾⓀⓁⓂ︎ⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ①②③④⑤⑥⑦⑧⑨⑩"

chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"

print len(circle)
print len(chars)

d = {n: chars[n] for n in range(len(circle))}

print d
