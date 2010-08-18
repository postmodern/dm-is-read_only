require 'spec_helper'

require 'classes/backend_model'
require 'classes/read_only_model'

describe DataMapper::Is::ReadOnly do
  context "migrate!" do
    before(:all) do
      BackendModel.auto_migrate!

      ('a'..'z').each do |value|
        BackendModel.create(:value => value)
      end

      ReadOnlyModel.migrate!
    end

    it "should not destroy the contents of the storage table" do
      ReadOnlyModel.all.length.should == 26
    end

    it "should still return true" do
      (ReadOnlyModel.auto_migrate!).should == true
    end
  end

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

    it "should prevent setting properties" do
      lambda {
        @resource.value = 'z'
      }.should raise_error(DataMapper::ReadOnlyError)
    end

    it "should prevent updating resources" do
      lambda {
        @resource.update(:value => 'z')
      }.should raise_error(DataMapper::ReadOnlyError)
    end

    it "should mark read-only resources as saved" do
      @resource.should be_saved
    end

    it "should mark read-only resources as clean" do
      @resource.should be_clean
    end

    it "should not mark read-only resources as dirty" do
      @resource.should_not be_dirty
    end

    it "should return true when calling save" do
      @resource.save.should == true
    end

    it "should return true when calling save!" do
      @resource.save!.should == true
    end

    it "should prevent calling destroy" do
      lambda {
        @resource.destroy
      }.should raise_error(DataMapper::ReadOnlyError)
    end

    it "should prevent calling destroy!" do
      lambda {
        @resource.destroy!
      }.should raise_error(DataMapper::ReadOnlyError)
    end

    it "should have an ReadOnly persisted state" do
      @resource.persisted_state.class.should == DataMapper::Resource::State::ReadOnly
    end

    it "should prevent forcibly changing the persisted state" do
      old_state = @resource.persisted_state

      new_state = DataMapper::Resource::State::Transient.new(@resource)
      @resource.persisted_state = new_state

      @resource.persisted_state.should == old_state
    end

    it "should report the resource as having already been saved" do
      @resource.should be_saved
    end
  end
end
