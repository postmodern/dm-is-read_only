module DataMapper
  module Is
    module ReadOnly
      #
      # Makes a Model and all resources of the model, read-only.
      #
      def is_read_only(options={})
        extend DataMapper::Is::ReadOnly::ClassMethods
        include DataMapper::Is::ReadOnly::InstanceMethods
      end

      module ClassMethods
        #
        # Disables auto-migrations.
        #
        # @return [true]
        #   Always returns `true`.
        #
        def self.auto_migrate!(repository_name=nil)
          return true
        end

        #
        # Disables auto-upgrades.
        #
        # @return [true]
        #   Always returns `true`.
        #
        def self.auto_upgrade!(repository_name=nil)
          return true
        end
      end

      module InstanceMethods
        #
        # Overrides the default `persisted_state` method, to always use
        # `DataMapper::Resource::State::Immutable`.
        #
        # @return [DataMapper::Resource::State::Immutable]
        #   The immutable state.
        #
        def persisted_state
          @_state = Resource::State::Immutable.new(self)
        end

        #
        # Prevents the persistence state from forcibly being changed.
        #
        # @param [DataMapper::Resource::State] new_state
        #   The new state to use.
        #
        # @raise [RuntimeError]
        #   Always raises a runtime error.
        #
        def persisted_state=(new_state)
          raise(RuntimeError,"Cannot forcible change the persistence state of a ReadOnly resource",caller)
        end
      end
    end
  end
end
