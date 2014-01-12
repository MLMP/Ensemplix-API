require 'composite_primary_keys'

class Member < ActiveRecord::Base
  self.table_name = 'regions_members'
  self.primary_keys = :region, :player, :world
end