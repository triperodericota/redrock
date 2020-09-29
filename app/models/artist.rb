class Artist < ApplicationRecord

  has_one :user, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :user
  has_and_belongs_to_many :fans
  has_many :events, dependent: :delete_all
  has_many :products

  validates :name, length: { maximum: 255 }, presence: true, uniqueness: true

  scope :with_search_name, -> (search_name) {where.has {name =~ search_name}}

  def to_param
    name
  end

  def amount_of_followers
    self.fans.size
  end

  def is_followed_for?(aFan)
    self.fans.include? aFan
  end

  def next_events
    # includes current events
    self.events.where("start_date >= :current OR
      start_date <= :current AND end_date >= :current", {current: DateTime.current})
  end

  def past_events
    self.events.where("end_date < ?" , DateTime.current)
  end


end
