class Question < ActiveRecord::Base
  delegate :options_as_list, :labels_as_list, :minimum_units, :maximum_units, :step, to: :widget

  belongs_to :section
  has_many :answers

  composed_of :widget, mapping: [%w(widget_type type), %w(options options), %w(labels labels),
    %(unit_amount unit_amount), %(unit_name unit_name), %(default_value default_value),
    %(size size), %(maxlength maxlength), %(placeholder placeholder), %(rows rows), %(cols cols)]

  validates_associated :widget

  validates :title, presence: true, unless: ->(q){q.widget.type == 'readonly'}
  validates :criteria, inclusion: { in: ->(q) { q.section.criterion } }, allow_blank: true

  before_save :strip_title_and_extra

  scope :budgetary, ->{ where('widget IN (?)', Widget::BUDGETARY) }
  scope :nonbudgetary, ->{ where('widget IN (?)', Widget::NONBUDGETARY) }
  # default_scope ->{ order(position: :asc) }
  

  private

  #
  def set_options
    if %w(scaler slider).include?(widget) && minimum_units.present? && maximum_units.present? && step.present?
      self.options = (minimum_units..maximum_units).step(step).map(&:to_s)
      self.options << maximum_units.to_s unless options.last == maximum_units
    elsif widget == 'onoff'
      self.options = [BigDecimal(0), BigDecimal(1)].map(&:to_s)
    elsif %w(checkboxes option radio select).include?(widget) && options_as_list.present?
      self.options = options_as_list.split("\n").map(&:strip).reject(&:empty?)
    else
      self.options = nil
    end
  end

  def set_labels
    if %w(onoff option).include?(widget) && labels_as_list.present?
      self.labels = labels_as_list.split("\n").map(&:strip).reject(&:empty?)
    end
  end

  def strip_title_and_extra
    self.title = title.strip if title?
    self.extra = extra.strip if extra?
  end
end
