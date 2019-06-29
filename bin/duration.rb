duration = 0.4.seconds

d = DateTime.parse('2019-01-01')

d += duration
d += duration
d += duration
d += duration
d += duration

p d > DateTime.parse('2019-01-01')
p d == DateTime.parse('2019-01-01')
