module IEX
  module Resources
    class Sectors < Resource
      property 'type'
      property 'name'
      property 'performance'
      property 'last_updated', from: 'lastUpdated'
    end
  end
end
