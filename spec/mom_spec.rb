require "spec_helper"

describe Mom do
  describe "oid" do
    it "should create a new object id with no parameters" do
      Mom.oid.must_be_kind_of BSON::ObjectId
    end
  
    it "should convert a legal string to object id" do
      id = BSON::ObjectId.new
      Mom.oid(id.to_s).must_equal id
    end
  
    it "should return a object if it gets an object id" do
      id = BSON::ObjectId.new
      Mom.oid(id).must_equal id
    end
  
    it "should not convert if it not a object id" do
      Mom.oid('hi').must_equal 'hi'
      Mom.oid(123).must_equal 123
    end
  
    it "should return nil for empty strings" do
      Mom.oid('').must_equal nil
    end
  end
end