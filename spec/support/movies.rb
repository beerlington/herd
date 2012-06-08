class Movies < Herd::Base
  model Movie

  scope :failures, where("revenue < '10000000'")

  def self.directed_by(director)
    where(directors: {name: director}).joins(:directors)
  end
end
