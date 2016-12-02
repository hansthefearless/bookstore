import json

with open("data.txt") as data_file:
	data = json.load(data_file)

categories = []

for k, v in data.iteritems():
	subject = v["subject"]
	if subject not in categories:
		categories.append(subject)

categories.sort()

print categories