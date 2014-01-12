require 'composite_primary_keys'

class Warp < ActiveRecord::Base
  self.primary_keys = :warp, :world
end
