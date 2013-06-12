require 'spec_helper'

describe ApiClient::Base do
  let(:user) { User.new }
  let(:collection) { Object.new }

  describe '.initialize' do
    context "with a hash {:a => 'a', :b => 'b'}" do
      before :each do
        @user = User.new({:a => 'a', :b => 'b'})
      end

      it 'should set #a' do
        @user.a.should == 'a'
      end

      it 'should set #b' do
        @user.b.should == 'b'
      end

      it 'should initialize errors' do
        @user.errors.should be_an_instance_of(ApiClient::Errors)
      end
    end

    context "with a hash with string keys {'a' => 'a', 'b' => 'b' }" do
      before :each do
        @user = User.new({ 'user' => { 'a' => 'a', "b" => "b" } })
      end

      it 'should initialize attributes' do
        @user.attributes.should == { :a => 'a', :b => 'b' }
      end
    end

    context 'with a root node' do
      before :each do
        @user = User.new({ :user => { :a => 'a', :b => 'b' } })
      end

      it 'should initialize attributes' do
        @user.attributes.should == { :a => 'a', :b => 'b' }
      end
    end
  end

  describe '.resource_path' do
    describe 'when not configured' do
      it 'should return a name based on the class name' do
        User.resource_path.should == 'users'
      end
    end

    describe 'when properly configured' do
      before :each do
        User.resource_path = 'admins'
      end

      it 'should return the resource_path value' do
        User.resource_path.should == 'admins'
      end
    end
  end

  describe '.resource_path=' do
    describe "with a string without '/'" do
      before :each do
        User.resource_path = 'users'
      end

      it 'should set it as passed' do
        User.resource_path.should == 'users'
      end
    end

    describe "with a string with '/'" do
      before :each do
        User.resource_path = '/users'
      end

      it "should set it without the '/'" do
        User.resource_path.should == 'users'
      end
    end
  end

  describe '.root_node' do
    context 'on a class without remote object specification' do
      it 'should return the class name' do
        User.root_node.should == 'user'
      end
    end

    context 'on a class with remote object specification' do
      it 'should return the class name' do
        Admin.root_node.should == 'user'
      end
    end
  end

  describe '.root_node=' do
    it 'should set the remote object name' do
      Admin.root_node.should == 'user'
    end
  end

  describe '#persisted?' do
    it 'should return false' do
      User.new.should_not be_persisted
    end
  end

  describe '.associations=' do
    before :each do
      @group = Group.new(:members => [ :user => {:a => 'a'}], :owner => {:b => 'b'})
    end

    it 'should instantiate a collection of members' do
      @group.members.should be_an_instance_of(Array)
    end

    it 'should instantiate the member' do
      @group.members.first.should be_an_instance_of(User)
    end

    it 'should instantiate the owner' do
      @group.owner.should be_an_instance_of(Admin)
    end
  end

  describe '.attributes' do
    it 'should return an array of attributes' do
      User.attributes.should == [:a, :b]
    end
  end

  describe '#attributes' do
    it 'should return a hash with the attributes and currently values' do
      User.new.attributes.should == { :a => nil, :b => nil }
    end
  end

  describe '.collection' do
    before :each do
      ApiClient::Collection.stub(:new).with(User, 'users').and_return(collection)
      collection.stub(:collection => [ user, user ])
    end

    it 'should return a collection of objects' do
      User.collection.should == [ user, user ]
    end
  end

  describe '#errors=' do
    before :each do
      @user = User.new(:errors => { 'a' => 'message', 'b' => 'message' })
    end

    it 'should set @errors with symbolic keys and messages as an array' do
      @user.errors.messages.should == { :a => %w(message), :b => %w(message) }
    end
  end

  describe 'requests' do
    context 'on the class' do
      before :each do
        stub_request(:any, 'http://api.example.com/users').to_return(:body => {'a' => 'b'}.to_json)
      end

      it 'should return a new instance' do
        User.get.should be_an_instance_of(User)
      end

      it 'should set the response on the instance' do
        User.get.response.should == { 'a' => 'b' }
      end
    end

    context 'on an object' do
      before :each do
        stub_request(:any, 'http://api.example.com/users').to_return(:body => {'a' => 'b'}.to_json)
        @user = User.new
      end

      it 'should return a new instance' do
        @user.get.should be_an_instance_of(User)
      end

      it 'should set the response on the instance' do
        @user.get.response.should == {'a' => 'b'}
      end
    end
  end
end
