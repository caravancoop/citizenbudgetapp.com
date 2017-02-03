module ApplicationHelper

  # <head> tags

  def title
    if @questionnaire
      "#{@questionnaire.organization.name} - #{@questionnaire.title}"
    else
      t 'app.product_name'
    end
  end

  def meta_description
    @questionnaire && @questionnaire.description
  end

  def author
    @questionnaire && @questionnaire.organization.name || t('app.author_name')
  end

  # Open Graph tags

  def og_title
    @questionnaire && @questionnaire.open_graph_title || title
  end

  def og_description
    @questionnaire && @questionnaire.open_graph_description || meta_description
  end

  def og_site_name
    @questionnaire && @questionnaire.title || t('app.product_name')
  end

  def og_url
    @questionnaire && present(@questionnaire) { |q| q.domain_url } || t('app.product_url')
  end

  def og_image
    if @questionnaire && @questionnaire.logo?
      if Rails.env.production?
        'http:' + @questionnaire.logo_url
      else
        root_url.chomp('/') + @questionnaire.logo_url
      end
    end
  end

  # Third-party integration

  def facebook_app_id
    @questionnaire && @questionnaire.facebook_app_id
  end

  def google_analytics_tracking_code
    @questionnaire && @questionnaire.google_analytics || t('.google_analytics')
  end

  # Only strip zeroes if all are insignificant.
  def currency(number, options = {})
    escaped_separator = Regexp.escape t(:'number.currency.format.separator', default: [:'number.format.separator', '.'])
    # Inexplicably, -0.0 renders as "-0" instead of 0 without this line.
    number = 0 if number.zero?
    # This logic should be in number_with_precision, but as long as the
    # separator occurs only once, this is safe.
    number_to_currency(number, options).sub /#{escaped_separator}0+\b/, ''
  end

  # @param [String] string a string
  # # @return [String] the string surrounded by locale-appropriate curly quotes
  def curly_quote(string)
    "#{t(:left_quote)}#{string}#{t(:right_quote)}"
  end

  # @param [String] string a string
  # @return [String] the string with escaped double-quotes for use in HTML attributes
  def escape_attribute(string)
    string.gsub '"', '&quot;'
  end

  # @return [Boolean] whether there is a single section
  def simple_navigation?
    @simulator.one?
  end

  # @param [String] custom a custom string
  # @param [String] default a default string
  # @return [String] the custom string if present, the default string otherwise
  def custom_or_default(custom, default)
    if custom.present?
      custom
    else
      default
    end
  end

  def bootstrap_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    options[:builder] ||= FormtasticBootstrap::FormBuilder
    semantic_form_for record_or_name_or_array, options, &proc
  end

  # Facebook uses underscores in locale identifiers (as do Unix systems).
  def system_locale
    if locale.to_s == 'en'
      'en_US'
    else
      locale.to_s.sub('-', '_')
    end
  end

  def iso639_locale
    locale.to_s.split('-', 2).first
  end

  # Used in both public and private controllers.

  def token_url(questionnaire)
    root_url(token: questionnaire.authorization_token, domain: questionnaire.domain? && questionnaire.domain || t('app.host'), subdomain: false)
  end

  MAX_DIMENSION = 560 # As for Bootstrap's .modal

  # @param [String] string a Markdown string that may contain HTML
  # @return [String] the HTML output
  def markdown(string)
    RDiscount.new(string).to_html.html_safe
  end

  def markdown_embed(html)
    content_tag(:div, markdown(html), class: 'extra clearfix')
  end

  # @param [CitizenBudgetModel::Question] question a question
  # @return [ActiveSupport::SafeBuffer] an "input" tag of type "range" with a
  #   "datalist" tag describing its options
  # @see http://afarkas.github.io/webshim/demos/demos/cfgs/input-range.html
  def range(question)
    id = "#{question.id}-#{question.name.parameterize}"
    minimum = float(question.minimum_units)
    maximum = float(question.maximum_units)
    step = float(question.step)
    default_value = float(question.default_value)

    values_with_labels = [minimum, maximum]
    unless request.headers['X_MOBILE_DEVICE']
      values_with_labels.insert(1, default_value)
    end

    options = ActiveSupport::SafeBuffer.new
    (minimum..maximum).step(step) do |value| # range needs min and max to respect step
      # Only display labels for default, minimum and maximum, to avoid crowding.
      attributes = {value: value}
      if values_with_labels.include?(value)
        attributes[:label] = question.unit_amount
      end
      options << content_tag('option', nil, attributes)
    end

    content_tag('label',
      content_tag('span', '', {class: 'tick lowest'}) +
      content_tag('span', '', {class: 'tick initial'}) +
      tag(:input, {
        id: question.id,
        name: "#{question.id}",
        type: 'range',
        min: minimum,
        max: maximum,
        step: step,
        value: default_value,
        list: id,
        style: 'display: none',
        alt: t(".alt_slider"),
      }) +
      content_tag('span', '', {class: 'tick highest'}), for: question.id
    ) +
    content_tag('datalist', content_tag('select', options, title: "datalist options"), id: id)
  end

private

  def float(number)
    float = Float(number)
    if float == number
      float
    else
      number
    end
  end
end
