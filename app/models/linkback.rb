class Linkback < ActiveRecord::Base
  validates :source_uri, presence: true, uniqueness: { scope: :target_uri }
  validates :target_uri, presence: true
end
