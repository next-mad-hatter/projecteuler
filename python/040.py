import time
w = time.time()
d = ''.join([`num` for num in xrange(1,190000)])
print int(d[0])*int(d[9])*int(d[99])*int(d[999])*int(d[9999])*int(d[99999])*int(d[999999])
print time.time() - w
