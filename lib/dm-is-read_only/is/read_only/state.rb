require 'dm-is-read_only/is/read_only/exceptions/error'

module DataMapper
  module Is
    module ReadOnly
      #
      # A lazy-loaded and unmodifiable resource.
      #
      class State < DataMapper::Resource::PersistenceState::Clean

        #
        # Receives modifications attempts on a read-only resource.
        #
        # @raise [ReadOnlyError]
        #   A read-only resource cannot be modified.
        #
        # @since 0.2.0
        #
        def set(subject,value)
          raise(Error,"ReadOnly resource cannot be modified",caller)
        end

        #
        # Receives deletion attempts on a read-only resource.
        #
        # @raise [ReadOnlyError]
        #   A read-only resource cannot be deleted.
        #
        # @since 0.2.0
        #
        def delete
          raise(Error,"ReadOnly resource cannot be deleted",caller)
        end

      end
    end
  end
end
