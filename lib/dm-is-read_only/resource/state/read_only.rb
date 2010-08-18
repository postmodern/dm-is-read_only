require 'dm-is-read_only/exceptions/read_only_error'

module DataMapper
  module Resource
    class State
      #
      # A lazy-loaded and unmodifiable resource.
      #
      class ReadOnly < Clean

        #
        # Receives modifications attempts on a read-only resource.
        #
        # @raise [ReadOnlyError]
        #   A read-only resource cannot be modified.
        #
        # @since 0.2.0
        #
        def set(subject,value)
          raise(ReadOnlyError,"ReadOnly resource cannot be modified",caller)
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
          raise(ReadOnlyError,"ReadOnly resource cannot be deleted",caller)
        end

      end
    end
  end
end
