class Linkback < ActiveRecord::Base
  validates_presence_of :source_uri, :target_uri
end
