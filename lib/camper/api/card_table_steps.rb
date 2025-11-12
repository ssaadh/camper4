# frozen_string_literal: true

module Camper
  class Client
    # Defines methods related to card table steps.
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_steps.md
    module CardTableStepsAPI
      # Create a step within a card
      #
      # @example
      #   client.create_card_table_step(bucket_id, card_id, 'Step title')
      # @example
      #   client.create_card_table_step(
      #     bucket_id,
      #     card_id,
      #     'Complete review',
      #     due_on: '2025-12-31',
      #     assignee_ids: [123, 456]
      #   )
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param card_id [Integer|String] the card id
      # @param title [String] the step title
      # @param options [Hash] extra parameters (due_on, assignee_ids)
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id, card_id, or title is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_steps.md#create-a-step
      def create_card_table_step(bucket_id, card_id, title, options = {})
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'card_id cannot be blank' if card_id.blank?
        raise Error::InvalidParameter, 'title cannot be blank' if title.blank?

        post(
          "/buckets/#{bucket_id}/card_tables/cards/#{card_id}/steps",
          body: { title: title, **options }
        )
      end

      # Update a step
      #
      # @example
      #   client.update_card_table_step(bucket_id, step_id, title: 'Updated step')
      # @example
      #   client.update_card_table_step(
      #     bucket_id,
      #     step_id,
      #     title: 'Review and approve',
      #     due_on: '2025-12-31',
      #     assignee_ids: [789]
      #   )
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param step_id [Integer|String] the step id
      # @param options [Hash] parameters to update (title, due_on, assignee_ids)
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or step_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_steps.md#update-a-step
      def update_card_table_step(bucket_id, step_id, options = {})
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'step_id cannot be blank' if step_id.blank?

        put("/buckets/#{bucket_id}/card_tables/steps/#{step_id}", body: options)
      end

      # Complete a step
      #
      # @example
      #   client.complete_card_table_step(bucket_id, step_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param step_id [Integer|String] the step id
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or step_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_steps.md#complete-a-step
      def complete_card_table_step(bucket_id, step_id)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'step_id cannot be blank' if step_id.blank?

        put("/buckets/#{bucket_id}/card_tables/steps/#{step_id}/completions")
      end

      # Uncomplete a step
      #
      # @example
      #   client.uncomplete_card_table_step(bucket_id, step_id)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param step_id [Integer|String] the step id
      # @return [Resource]
      # @raise [Error::InvalidParameter] if bucket_id or step_id is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_steps.md#uncomplete-a-step
      def uncomplete_card_table_step(bucket_id, step_id)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'step_id cannot be blank' if step_id.blank?

        put("/buckets/#{bucket_id}/card_tables/steps/#{step_id}/completions")
      end

      # Reposition a step within a card
      #
      # @example
      #   client.reposition_card_table_step(bucket_id, card_id, step_id, 0)
      #
      # @param bucket_id [Integer|String] the project/bucket id
      # @param card_id [Integer|String] the card id
      # @param step_id [Integer|String] the step id to move
      # @param position [Integer] the new position (0-indexed)
      # @return [Resource]
      # @raise [Error::InvalidParameter] if any parameter is blank or position is negative
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/card_table_steps.md#reposition-a-step
      def reposition_card_table_step(bucket_id, card_id, step_id, position)
        raise Error::InvalidParameter, 'bucket_id cannot be blank' if bucket_id.blank?
        raise Error::InvalidParameter, 'card_id cannot be blank' if card_id.blank?
        raise Error::InvalidParameter, 'step_id cannot be blank' if step_id.blank?
        raise Error::InvalidParameter, 'position must be at least 0' if position.to_i < 0

        post(
          "/buckets/#{bucket_id}/card_tables/cards/#{card_id}/positions",
          body: { step_id: step_id, position: position }
        )
      end
    end
  end
end
