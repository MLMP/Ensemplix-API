require 'composite_primary_keys'

class Region < ActiveRecord::Base
  self.primary_keys = :region, :world
end
