class Artist < ApplicationRecord

  include Rails.application.routes.url_helpers

  has_one :user, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :user
  has_and_belongs_to_many :fans
  has_many :events, dependent: :delete_all
  has_many :products

  validates :name, length: { maximum: 255 }, presence: true, uniqueness: true

  scope :with_search_name, -> (search_name) {where ("name LIKE ?"), search_name}

  def to_s
    self.name
  end

  def base_uri
    artist_path(self)
  end

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
