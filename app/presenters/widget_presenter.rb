class WidgetPresenter < Bourgeois::Presenter

  # @return [String] the "No" label for an on-off widget
  def no_label
    type == 'onoff' && labels? && labels.first || I18n.t('labels.no_label')
  end

  # @return [String] the "Yes" label for an on-off widget
  def yes_label
    type == 'onoff' && labels? && labels.last || I18n.t('labels.yes_label')
  end
end
