module NumbersHelper
  def locale_number_with_delimiter(number, locale)
    default = default_number_format(locale)

    format = t('number.format', locale: locale, default: default)
    number_with_delimiter(number, format)
  end

  private

  def default_number_format(locale)
    case locale
    when :en, :ja
      { delimiter: ',', separator: '.' }
    when :de, :it
      { delimiter: '.', separator: ',' }
    when :sv
      { delimiter: ' ', separator: ',' }
    when :ruby
      { delimiter: '_', separator: '.' }
    else
      { delimiter: ',', separator: '.' }
    end
  end
end
