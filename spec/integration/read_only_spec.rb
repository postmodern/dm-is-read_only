require 'spec_helper'

describe DataMapper::Is::ReadOnly do
  describe "migrate!" do
    it "should not destroy the contents of the storage table" do
      ReadOnlyModel.migrate!

      ReadOnlyModel.all.length.should == 26
    end

    it "should still return true" do
      (ReadOnlyModel.migrate!).should == true
    end
  end

  describe "auto_migrate!" do
    it "should not destroy the contents of the storage table" do
      ReadOnlyModel.auto_migrate!

      ReadOnlyModel.all.length.should == 26
    end

    it "should still return true" do
      (ReadOnlyModel.auto_migrate!).should == true
    end
  end

  describe "auto_upgrade!" do
  end

  describe "immutable" do
    TransientState = if defined?(DataMapper::Resource::PersistenceState)
                       DataMapper::Resource::PersistenceState::Transient
                     else
                       DataMapper::Resource::State::TransientState
                     end

    before(:all) do
      @resource = ReadOnlyModel.first(:value => 'x')

      RelatedModel.create(:read_only_model => @resource)

      @related_resource = RelatedModel.first
    end

    it "should have an ReadOnly persisted state" do
      @resource.persistence_state.class.should == described_class::State
    end

    it "should prevent setting properties" do
      lambda {
        @resource.value = 'z'
      }.should raise_error(DataMapper::Is::ReadOnly::Error)
    end

    it "should prevent updating resources" do
      lambda {
        @resource.update(:value => 'z')
      }.should raise_error(DataMapper::Is::ReadOnly::Error)
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
      }.should raise_error(DataMapper::Is::ReadOnly::Error)
    end

    it "should prevent calling destroy!" do
      lambda {
        @resource.destroy!
      }.should raise_error(DataMapper::Is::ReadOnly::Error)
    end

    it "should prevent forcibly changing the persisted state" do
      old_state = @resource.persistence_state

      new_state = TransientState.new(@resource)
      @resource.persistence_state = new_state

      @resource.persistence_state.should == old_state
    end

    it "should report the resource as having already been saved" do
      @resource.should be_saved
    end

    it "should still allow relationships with non-read-only models" do
      @resource.related_models.first.should == @related_resource
      @related_resource.read_only_model.should == @resource
    end
  end
end
