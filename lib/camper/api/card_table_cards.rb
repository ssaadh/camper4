# frozen_string_literal: true

module Camper
  class Client
    # Defines methods related to card table cards.
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_cards.md
    module CardTableCardsAPI
      # Get the cards in a column
      #
      # @example
      #   client.card_table_cards(bucket_id, column_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param column_id [Integer|String] the column/list id
      # @param options [Hash] options to filter the list of cards
      # @return [PaginatedResponse<Resource>]
      # @raise [Error::InvalidParameter] if bucket_id or column_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_cards.md#get-cards
      def card_table_cards(bucket_id, column_id, options = {})
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?

        get("/buckets/#{bucket_id}/card_tables/lists/#{column_id}/cards", query: options)
      end

      # Get a single card
      #
      # @example
      #   client.card_table_card(bucket_id, card_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param card_id [Integer|String] the card id
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or card_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_cards.md#get-a-card
      def card_table_card(bucket_id, card_id)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'card_id cannot be blank' if card_id.blank?

        get("/buckets/#{bucket_id}/card_tables/cards/#{card_id}")
      end

      # Create a card in a column
      #
      # @example
      #   client.create_card_table_card(bucket_id, column_id, 'Card Title')
      # @example
      #   client.create_card_table_card(
      #     bucket_id,
      #     column_id,
      #     'Card Title',
      #     content: '<div>Card description</div>',
      #     due_on: '2025-12-31',
      #     notify: true
      #   )
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param column_id [Integer|String] the column/list id
      # @param title [String] the card title
      # @param options [Hash] extra parameters (content, due_on, notify)
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id, column_id, or title is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_cards.md#create-a-card
      def create_card_table_card(bucket_id, column_id, title, options = {})
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'column_id cannot be blank' if column_id.blank?
        raise Error::InvalidParameter, 'title cannot be blank' if title.blank?

        post(
          "/buckets/#{bucket_id}/card_tables/lists/#{column_id}/cards",
          body: { title: title, **options }
        )
      end

      # Update a card
      #
      # @example
      #   client.update_card_table_card(bucket_id, card_id, title: 'New Title')
      # @example
      #   client.update_card_table_card(
      #     bucket_id,
      #     card_id,
      #     title: 'Updated Title',
      #     content: '<div>Updated content</div>',
      #     due_on: '2025-12-31',
      #     assignee_ids: [123, 456]
      #   )
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param card_id [Integer|String] the card id
      # @param options [Hash] parameters to update (title, content, due_on, assignee_ids)
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or card_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_cards.md#update-a-card
      def update_card_table_card(bucket_id, card_id, options = {})
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'card_id cannot be blank' if card_id.blank?

        put("/buckets/#{bucket_id}/card_tables/cards/#{card_id}", body: options)
      end
    end
  end
end
