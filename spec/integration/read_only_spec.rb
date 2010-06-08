require 'spec_helper'

require 'classes/backend_model'
require 'classes/read_only_model'

describe DataMapper::Is::ReadOnly do
  context "auto_migrate!" do
    before(:all) do
      BackendModel.auto_migrate!

      ('a'..'z').each do |value|
        BackendModel.create(:value => value)
      end

      ReadOnlyModel.auto_migrate!
    end

    it "should not destroy the contents of the storage table" do
      ReadOnlyModel.all.length.should == 26
    end

    it "should still return true" do
      (ReadOnlyModel.auto_migrate!).should == true
    end
  end

  context "auto_upgrade!" do
  end

  context "immutable" do
    before(:all) do
      BackendModel.auto_migrate!
      BackendModel.create(:value => 'x')

      @resource = ReadOnlyModel.first(:value => 'x')
    end

    it "should prevent modifying properties" do
      lambda {
        @resource.value = 'z'
      }.should raise_error()
    end

    it "should prevent calling save" do
      lambda {
        @resource.save
      }.should raise_error()
    end

    it "should prevent calling save!" do
      lambda {
        @resource.save!
      }.should raise_error()
    end

    it "should prevent calling destroy" do
      @resource.destroy

      original = BackendModel.first(:value => 'x')
      original.should_not be_nil
    end

    it "should prevent calling destroy!" do
      @resource.destroy!

      original = BackendModel.first(:value => 'x')
      original.should_not be_nil
    end

    it "should have an Immutable persisted state" do
      @resource.persisted_state.class.should == DataMapper::Resource::State::Immutable
    end

    it "should prevent forcibly changing the persisted state" do
      old_state = @resource.persisted_state

      new_state = DataMapper::Resource::State::Transient.new(@resource)
      @resource.persisted_state = new_state

      @resource.persisted_state.should == old_state
    end
  end
end
