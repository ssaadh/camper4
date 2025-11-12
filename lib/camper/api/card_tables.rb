# frozen_string_literal: true

module Camper
  class Client
    # Defines methods related to card tables.
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_tables.md
    module CardTablesAPI
      # Get a card table
      #
      # @example
      #   client.card_table(bucket_id, card_table_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param id [Integer|String] id of the card table to retrieve
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_tables.md#get-a-card-table
      def card_table(bucket_id, id)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'id cannot be blank' if id.blank?

        get("/buckets/#{bucket_id}/card_tables/#{id}")
      end
    end
  end
end
