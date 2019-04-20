module PagSeguro
  class Response < Hashie::Mash
    protected

    def convert_key(key)
      key.to_s.underscore
    end

    def convert_value(val, duping = false)
      obj = super
      obj = self.class.new(obj) if Hashie::Mash == obj
      obj
    end

    def initializing_reader(key)
      ck = convert_key(key)
      regular_writer(ck, self.class.new) unless key?(ck)
      regular_reader(ck)
    end
  end
end
