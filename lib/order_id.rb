require 'order_id/version'
require 'bigdecimal'
module OrderId
  DECIMAL_PLACES = 20
  BASE           = 36
  SEPARATOR      = '-'
  GROUP_LENGTH   = 5
  ALLOWED_SEPARATORS = ['-', '_', '|', ':', '@', '.', '/', '#', '!', '$', '%', '^', '&', '*', '(', ')', '[', ']', '{', '}'].freeze

  class FormatError < StandardError; end

  def self.generate(decimal_places: DECIMAL_PLACES, base: BASE, separator: SEPARATOR, group_length: GROUP_LENGTH)
    raise FormatError, "Characters not allowed as separator: '#{separator}'" unless ALLOWED_SEPARATORS.include?(separator)
    raise FormatError, 'Length should be positive' unless decimal_places.positive?

    t = Time.now.to_f
    ts = format("%.#{decimal_places}f", t).delete('.')
    final = ts.to_i.to_s(base).upcase
    final.scan(/.{1,#{group_length}}/).join(separator)
  end

  def self.get_time(id, decimal_places: DECIMAL_PLACES, base: BASE, separator: SEPARATOR)
    id.delete!(separator)
    ts = id.to_i(base) / BigDecimal("1e+#{decimal_places}")
    Time.at(ts)
  end
end
