# Must implement `sections` and `responses` methods
module SpreadsheetExportable
  extend ActiveSupport::Concern
  
  included do

    # @return [Array] a list of headers for a spreadsheet
    def headers
      # If the first two letters of a file are "ID", Microsoft Excel will try to
      # open the file in the SYLK file format.
      headers = %w(ip id created_at time_to_complete email name)
      if assessment?
        headers << 'assessment'
      end
      headers
    end

    # @return [Array] rows for a spreadsheet
    def rows
      rows = []

      # Add headers
      row = headers.map do |column|
        Response.human_attribute_name(column)
      end
      sections.each do |section|
        section.questions.each do |question|
          row << question.title
        end
      end
      rows << row

      # Add defaults
      row = headers.map do |column|
        I18n.t(:default)
      end
      sections.each do |section|
        section.questions.each do |question|
          if ['checkbox', 'onoff', 'option', 'slider', 'scaler'].include?(question.widget)
            row << question.default_value || I18n.t(:default)
          else
            row << I18n.t(:default)
          end
        end
      end
      rows << row

      # Add data
      responses.each do |response|
        row = headers.map do |column|
          if column == 'id'
            response.id.to_s # axlsx may error when trying to convert Moped::BSON::ObjectId
          elsif column != 'assessment' || assessment?
            response.send(column)
          end
        end

        sections.each do |section|
          section.questions.each do |question|
            answer = response.cast_answer(question)
            if Array === answer
              row << answer.to_sentence
            else
              row << answer
            end
          end
        end
        rows << row
      end

      rows
    end
  end
end
