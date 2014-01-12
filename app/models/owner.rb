require 'composite_primary_keys'

class Owner < ActiveRecord::Base
  self.table_name = 'regions_owners'
  self.primary_keys = :region, :player, :world
end