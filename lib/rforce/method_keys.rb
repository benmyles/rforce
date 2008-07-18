module RForce
  # Allows indexing hashes like method calls: hash.key
  # to supplement the traditional way of indexing: hash[key]
  module MethodKeys
    def method_missing(method, *args)
      self[method]
    end
  end
  
  class MethodHash < Hash
    include MethodKeys
  end
end
