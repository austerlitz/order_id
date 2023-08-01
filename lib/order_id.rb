require 'order_id/version'
require 'bigdecimal'
module OrderId
  DECIMAL_PLACES     = 20
  BASE               = 36
  SEPARATOR          = '-'
  GROUP_LENGTH       = 5

  def self.generate(decimal_places: DECIMAL_PLACES, base: BASE, separator: SEPARATOR, group_length: GROUP_LENGTH, timestamp: Time.now.to_f)
    raise ArgumentError, "Invalid separator: '#{separator}'. Separator should be a non-alphanumeric character." unless separator =~ /[^a-zA-Z0-9]/
    raise ArgumentError, "Invalid decimal places: '#{decimal_places}'. Decimal places should be a positive integer." unless decimal_places.is_a?(Integer) && decimal_places.positive?
    raise ArgumentError, "Invalid base: '#{base}'. Base should be an integer between 2 and 36." unless base.is_a?(Integer) && base.between?(2, 36)
    raise ArgumentError, "Invalid group length: '#{group_length}'. Group length should be a positive integer." unless group_length.is_a?(Integer) && group_length.positive?
    raise ArgumentError, "Invalid timestamp: '#{timestamp}'. Timestamp should be a floating point number." unless timestamp.is_a?(Float)

    ts = format("%.#{decimal_places}f", timestamp).delete('.')
    final = ts.to_i.to_s(base).upcase
    final.scan(/.{1,#{group_length}}/).join(separator)
  end

  def self.get_time(id, decimal_places: DECIMAL_PLACES, base: BASE, separator: SEPARATOR)
    id.delete!(separator)
    ts = id.to_i(base) / BigDecimal("1e+#{decimal_places}")
    Time.at(ts)
  end
end
