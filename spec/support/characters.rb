class Characters < Herd::Base
  model Character

  scope :fat, where(name: 'chunk')
end
