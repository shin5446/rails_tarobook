class Blog < ApplicationRecord
  validates :title, presence: true,length: { maximum: 50 }
  validates :content, presence: true,length: { maximum: 600 }

end

