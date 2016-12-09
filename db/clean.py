import json

from time import sleep
import urllib2


# def loadURL(isbn):
# 	global info
# 	# info = urllib2.urlopen("https://www.googleapis.com/books/v1/volumes?q="+isbn).read()
# 	try:
# 		info = urllib2.urlopen("https://www.googleapis.com/books/v1/volumes?q="+isbn+"&key=AIzaSyBmApa6BaBkKYFPQml9K3yfDn7e7dnp494").read()
# 		# +"&key=AIzaSyBmApa6BaBkKYFPQml9K3yfDn7e7dnp494"
# 	except Exception:
# 		# sleep(2)
		# loadURL(isbn)


with open("data.txt") as data_file:
	data = json.load(data_file)

categories = []

for k, v in data.iteritems():
	subject = v["subject"]
	if subject not in categories:
		categories.append(subject)

categories.sort()

print categories
# newdata = data
newdata = {}

# counter = 1

for k, v in data.iteritems():
	# try:
		image = v["thumbnail"]
		if image == None:
			print v["ISBN"]
		else:
			newdata[k] = v

	# 	isbn = v["ISBN"]
	# 	info = urllib2.urlopen("https://www.googleapis.com/books/v1/volumes?q="+isbn+"&key=AIzaSyBmApa6BaBkKYFPQml9K3yfDn7e7dnp494").read()
	# 	googleinfo = json.loads(info)
	# 	image = googleinfo["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
	# 	newdata[k]["thumbnail"] = image
	# 	print counter
	# 	counter += 1
	# except:
	# 	newdata[k]["thumbnail"] = None
	# 	print "fail", isbn



# with open("brandnewdata.txt", "w") as outfile:
# 	json.dump(newdata, outfile)

# print "Data extraction complete"
