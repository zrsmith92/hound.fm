require 'faye'

bayeux = Faye::RackAdapter.new(:mount => '/updates', :timeout => 25)
bayeux.listen(9292)
