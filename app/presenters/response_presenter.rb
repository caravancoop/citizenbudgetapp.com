class ResponsePresenter < Bourgeois::Presenter

  # @return [String] the full first name and last name initial
  def display_name
    if name?
      parts = name.strip.split(' ', 2)
      parts[0] = UnicodeUtils.titlecase(parts[0]) if parts[0][/\A\p{Ll}/]
      parts[1] = "#{UnicodeUtils.upcase(parts[1][0])}." if parts[1]
      parts.join ' '
    end
  end

  # @param [Section] section a questionnaire section
  # @return [String] the value of the HTML `id` attribute for the section
  def table_id(section)
    parts = []
    parts << 'section'
    parts << section.position.to_i + 1
    parts << section.title.parameterize if section.title.present?
    parts.map(&:to_s) * '-'
  end
end
