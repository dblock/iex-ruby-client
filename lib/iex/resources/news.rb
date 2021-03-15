module IEX
  module Resources
    class News < Resource
      property 'datetime', transform_with: ->(v) { Time.at(v / 1000.0) }
      property 'headline'
      property 'source'
      property 'url'
      property 'summary'
      property 'image'
      property 'related', transform_with: ->(v) { v.split(',') if v.is_a?(String) }
      property 'paywalled', from: 'hasPaywall'
      property 'language', from: 'lang'
    end
  end
end
