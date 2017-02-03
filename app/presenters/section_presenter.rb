class SectionPresenter < Bourgeois::Presenter

  # @return [String] the value of the HTML `id` attribute for the section
  def table_id
    parts = []
    parts << 'section'
    parts << position.to_i + 1
    parts << title.parameterize if title.present?
    parts.map(&:to_s) * '-'
  end

  # @return [Boolean] whether the "Read more" content is a URL
  def extra_url?
    extra? && extra[%r{\Ahttps?://\S+\z}]
  end
end
