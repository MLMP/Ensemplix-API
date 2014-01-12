class Block < ActiveRecord::Base
  self.table_name = 'logs_blocks'
  self.inheritance_column = 'block_type'
end