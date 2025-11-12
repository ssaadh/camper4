# frozen_string_literal: true

module Camper
  class Client
    # Defines methods related to card table columns.
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md
    module CardTableColumnsAPI
      VALID_COLORS = %w[white red orange yellow green blue aqua purple gray pink brown].freeze

      # Get a column
      #
      # @example
      #   client.card_table_column(bucket_id, column_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param column_id [Integer|String] the column id
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or column_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md#get-a-column
      def card_table_column(bucket_id, column_id)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?

        get("/buckets/#{bucket_id}/card_tables/columns/#{column_id}")
      end

      # Create a column in a card table
      #
      # @example
      #   client.create_card_table_column(bucket_id, card_table_id, 'To Do')
      # @example
      #   client.create_card_table_column(bucket_id, card_table_id, 'In Progress', description: 'Work in progress')
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param card_table_id [Integer|String] the card table id
      # @param title [String] the column title
      # @param options [Hash] extra parameters (description)
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id, card_table_id, or title is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md#create-a-column
      def create_card_table_column(bucket_id, card_table_id, title, options = {})
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'card_table_id cannot be blank' if card_table_id.blank?
        raise Error::InvalidParameter, 'title cannot be blank' if title.blank?

        post(
          "/buckets/#{bucket_id}/card_tables/#{card_table_id}/columns",
          body: { title: title, **options }
        )
      end

      # Update a column
      #
      # @example
      #   client.update_card_table_column(bucket_id, column_id, title: 'Done')
      # @example
      #   client.update_card_table_column(bucket_id, column_id, title: 'Completed', description: 'Finished tasks')
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param column_id [Integer|String] the column id
      # @param options [Hash] parameters to update (title, description)
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or column_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md#update-a-column
      def update_card_table_column(bucket_id, column_id, options = {})
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?

        put("/buckets/#{bucket_id}/card_tables/columns/#{column_id}", body: options)
      end

      # Move a column within a card table
      #
      # @example
      #   client.move_card_table_column(bucket_id, card_table_id, column_id, 2)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param card_table_id [Integer|String] the card table id
      # @param column_id [Integer|String] the column id to move
      # @param position [Integer] the new position (1-indexed)
      # @return [Resource]
      # @raise [Error::InvalidParameter] if any parameter is blank or position is less than 1
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md#reposition-a-column
      def move_card_table_column(bucket_id, card_table_id, column_id, position)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'card_table_id cannot be blank' if card_table_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?
        raise Error::InvalidParameter, 'position must be at least 1' if position.to_i < 1

        post(
          "/buckets/#{bucket_id}/card_tables/#{card_table_id}/moves",
          body: { column_id: column_id, position: position }
        )
      end

      # Subscribe to a column
      #
      # @example
      #   client.subscribe_to_card_table_column(bucket_id, column_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param column_id [Integer|String] the column/list id
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or column_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md#subscribe-to-a-column
      def subscribe_to_card_table_column(bucket_id, column_id)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?

        post("/buckets/#{bucket_id}/card_tables/lists/#{column_id}/subscription")
      end

      # Unsubscribe from a column
      #
      # @example
      #   client.unsubscribe_from_card_table_column(bucket_id, column_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param column_id [Integer|String] the column/list id
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or column_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md#unsubscribe-from-a-column
      def unsubscribe_from_card_table_column(bucket_id, column_id)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?

        delete("/buckets/#{bucket_id}/card_tables/lists/#{column_id}/subscription")
      end

      # Create an on-hold section in a column
      #
      # @example
      #   client.create_card_table_column_on_hold(bucket_id, column_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param column_id [Integer|String] the column id
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or column_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md#create-an-on-hold-section
      def create_card_table_column_on_hold(bucket_id, column_id)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?

        post("/buckets/#{bucket_id}/card_tables/columns/#{column_id}/on_hold")
      end

      # Remove an on-hold section from a column
      #
      # @example
      #   client.remove_card_table_column_on_hold(bucket_id, column_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param column_id [Integer|String] the column id
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or column_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md#remove-an-on-hold-section
      def remove_card_table_column_on_hold(bucket_id, column_id)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?

        delete("/buckets/#{bucket_id}/card_tables/columns/#{column_id}/on_hold")
      end

      # Change a column's color
      #
      # @example
      #   client.change_card_table_column_color(bucket_id, column_id, 'blue')
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param column_id [Integer|String] the column id
      # @param color [String] the new color (white, red, orange, yellow, green, blue, aqua, purple, gray, pink, brown)
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id, column_id is blank or color is invalid
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_columns.md#change-a-columns-color
      def change_card_table_column_color(bucket_id, column_id, color)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?
        raise Error::InvalidParameter, "color must be one of: #{VALID_COLORS.join(', ')}" unless VALID_COLORS.include?(color)

        put("/buckets/#{bucket_id}/card_tables/columns/#{column_id}/color", body: { color: color })
      end
    end
  end
end
