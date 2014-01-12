require 'composite_primary_keys'

class Flag < ActiveRecord::Base
  self.table_name = 'regions_flags'
  self.primary_keys = :region, :flag, :world
end