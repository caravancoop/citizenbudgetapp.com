class QuestionPresenter < Bourgeois::Presenter

  # @return [String] the name to display in the administrative interface
  def name
    title? && title || I18n.t(:untitled)
  end

  # @param [Question] question a questionnaire question
  # @return [Hash] the HTML attributes for the question's `input` tag
  def html_attributes
    attributes = {}
    classes = []

    value = self.default_value
    attributes[:value] = value if value.present?

    [:size, :maxlength, :placeholder, :rows, :cols].each do |attribute|
      value = self[attribute]
      attributes[attribute] = value if value.present?
    end

    if self.size.present? || self.cols.present?
      span = case self.size || self.cols # 210px is the default
      when 0..5
        'span1' # 50px
      when 6..18
        'span2' # 130px
      when 33..45
        'span4' # 290px
      when 46..58
        'span5' # 370px
      when 59..72
        'span6' # 450px
      when 73..85
        'span7' # 530px
      when 86..98
        'span8' # 610px
      when 99..112
        'span9' # 690px
      when 113..125
        'span10' # 770px
      end
      classes << span if span
    end

    if required?
      attributes[:required] = Formtastic::FormBuilder.use_required_attribute
      classes << 'validate[required]'
    end

    attributes[:class] = classes.join(' ') unless classes.empty?
    attributes
  end
end
