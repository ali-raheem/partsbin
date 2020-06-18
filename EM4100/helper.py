def get_bitstring(n):
	return "{0:b}".format(n)

def print_csv(bs):
	i = 0
	for b in bs:
		print(b, end='')
		i += 1
		if (i % 4 == 0):
			print("")
		else:
			print(",", end="")
