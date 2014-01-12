require 'composite_primary_keys'

  class Child < ActiveRecord::Base
    self.table_name = 'regions_childs'
    self.primary_keys = :parent, :child, :world
  end