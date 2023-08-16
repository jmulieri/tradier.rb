require 'spec_helper'

describe Tradier::Error do

  describe "#initialize" do
    it "wraps another error class" do
      begin
        raise Faraday::ClientError.new("Oops")
      rescue Faraday::ClientError
        begin
          raise Tradier::Error
        rescue Tradier::Error => error
          expect(error.message).to eq "Oops"
          expect(error.wrapped_exception.class).to eq Faraday::ClientError
        end
      end
    end
  end

  describe "#errors" do
    it "lists descendant errors" do
      expect(Tradier::Error.errors).to have_key(403)
    end
  end

end
