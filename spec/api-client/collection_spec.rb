require 'spec_helper'

describe ApiClient::Collection do
  let(:user) { User.new }

  describe '.initialize' do
    it 'should save the class in an instance_variable' do
      ApiClient::Collection.new([], User).instance_variable_get('@klass').should == User
    end

    context 'with a hash of attributes' do
      before :each do
        attributes =  { 'users' => [ { :user => { :a => 'a' } }, { :user => { :b => 'b' } } ] }
        @collection = ApiClient::Collection.new(attributes, User)
      end

      it 'should initialize a collection of objects' do
        @collection.size.should == 2
      end
    end

    context 'with a collection of attributes' do
      before :each do
        attributes = [ { :user => { :a => 'a' } }, { :user => { :b => 'b' } } ]
        @collection = ApiClient::Collection.new(attributes, User)
      end

      it 'should initialize a collection of objects' do
        @collection.size.should == 2
      end
    end

    context 'with a single object attribute' do
      before :each do
        attributes = { :user => { :a => 'a' } }
        @collection = ApiClient::Collection.new(attributes, User)
      end

      it 'should initialize a single object' do
        @collection.size.should == 1
      end
    end
  end

  describe '#update' do
    before :each do
      attributes = [ { :user => { :a => 'a' } }, { :user => { :b => 'b' } } ]
      @collection = ApiClient::Collection.new(attributes, User)
    end

    context 'with a hash of attributes' do
      it 'Should update the collection with new objects based on the attributes' do
        @collection.update({ 'users' => [ { :user => { :a => 'a' } }, { :user => { :b => 'b' } } ] }).size.should == 2
      end
    end

    context 'with a collection of attributes' do
      it 'Should update the collection with new objects based on the attributes' do
        @collection.update([ { :user => { :a => 'a' } }, { :user => { :b => 'b' } } ]).size.should == 2
      end
    end

    context 'with a single object attribute' do
      it 'should update the collection with the new object based on the attributes' do
        @collection.update({ :user => { :a => 'a' } }).size.should == 1
      end
    end
  end
end