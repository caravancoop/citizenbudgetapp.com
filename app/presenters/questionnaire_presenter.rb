class QuestionnairePresenter < Bourgeois::Presenter


  def logo_image
    options = {alt: ''}
    if self.logo_height?
      options[:height] = [self.logo_height, 100].min
    end
    link_to_unless_current image_tag(self.logo.large.url, options), root_path
  end

  # @return [Integer] the number of days elapsed
  def days_elapsed
    (today - starts_on).to_i
  end

  # @return [Integer] the number of days left
  def days_left
    (ends_on - today).to_i
  end

  # @return [String,nil] the consultation's URL, or nil
  def domain_url
    domain? && "http://#{domain}"
  end

  def chart_data # @todo Significant duplication of dashboard.rb
    number_of_responses = responses.count
    reponses = responses.to_a

    all_details = {}
    sections.map(&:questions).flatten.each do |question|
      next unless question.widget

      details = {}
      if question.budgetary?
        changes = responses.select{|r| r.answers[question.id.to_s] != question.default_value}
        number_of_changes = changes.size
        number_of_nonchanges = number_of_responses - number_of_changes

        # Start with all the respondents who did not change the value.
        choices = [question.cast_default_value] * number_of_nonchanges

        changes.each do |response|
          choices << response.cast_answer(question)
        end

        details.merge!({
          :choices => choices,
          # Question parameters.
          :minimum_units => question.minimum_units,
          :maximum_units => question.maximum_units,
          :step          => question.step,
          :unit_name     => question.unit_name,
          :default_value => question.default_value,
          :widget        => question.widget,
          # How large were the modifications?
          :mean_choice   => choices.sum / number_of_responses.to_f,
          :n             => number_of_responses,
        })

        if question.widget == 'onoff'
          details[:labels] = if question.checked?
            [question.yes_label, question.no_label]
          else
            [question.no_label, question.yes_label]
          end
        end

        if question.widget == 'option'
          details[:counts] = Hash.new(0)
          changes.each do |response|
            details[:counts][response.answer(question)] += 1
          end
          details[:counts][question.default_value] = number_of_nonchanges

          details[:raw_counts] = details[:counts].clone
          details[:counts].each do |option,count|
            details[:counts][option] /= number_of_responses.to_f
          end

          details[:options] = question.options
          details[:labels] = question.labels
        end
      # Multiple choice survey questions.
    elsif question.options.any?
        changes = responses.select{|r| r.answers[question.id.to_s]}
        number_of_changes = changes.size

        details[:counts] = Hash.new(0)
        question.options.each do |option|
          details[:counts][option] = 0
        end
        changes.each do |response|
          answer = response.answer(question)
          if question.multiple?
            answer.each do |a|
              details[:counts][a] += 1
            end
          else
            if details[:counts].key?(answer) || answer.present?
              details[:counts][answer] += 1
            end
          end
        end

        details[:raw_counts] = details[:counts].clone
        if number_of_changes.nonzero?
          details[:counts].each do |answer,count|
            details[:counts][answer] /= number_of_changes.to_f
          end
        end
      end

      all_details[question.id.to_s] = details
    end

    all_details
  end
end
