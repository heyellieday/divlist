class Tweet < ActiveRecord::Base
  belongs_to :twitter_profile
  belongs_to :post
end
