class SiteConfiguration
  include Mongoid::Document
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :key, type: String
  field :value
end
