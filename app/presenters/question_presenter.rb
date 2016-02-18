class QuestionPresenter < Bourgeois::Presenter

  # @return [String] the name to display in the administrative interface
  def name
    title? && title || I18n.t(:untitled)
  end
end
