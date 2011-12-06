module Hound

	# Hound has never searched for this artist before, just added it to the DB
	STATUS_NEVER_RUN	= -1

	# Hound isn't doing anyting with this artist
	STATUS_IDLE			= 0

	# Hound is currently searching for this artist's data on the intertubez
	STATUS_RUNNING		= 1

	# Minimum string difference required to be considered 2 different pieces of media
	MIN_DIFFERENCE		= 5

	DRIVER_DIR = "#{ File.dirname(__FILE__) }/drivers"	


end