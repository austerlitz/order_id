require "OrderId/version"
require 'bigdecimal'
module OrderId
  DECIMAL_LENGTH = 20
  BASE           = 36
  SEPARATOR      = '-'
  GROUP_LENGTH   = 5
  class FormatError < StandardError; end

  def self.generate(length: DECIMAL_LENGTH, base: BASE, separator: SEPARATOR, group_length: GROUP_LENGTH)
    if separator =~ (/[\w\d]/)
      raise FormatError, "Characters not allowed as separator: `#{separator}`"
    end
    t  = Time.now.to_f
    ts = "%.#{length}f" % t
    ts.delete!('.')
    final = ts.to_i.to_s(base).upcase
    final.scan(/.{1,#{group_length}}/).join(separator)
  end

  def self.get_time(id, length: DECIMAL_LENGTH, base: BASE, separator: SEPARATOR)
    id.delete!(separator)
    ts = id.to_i(base) / BigDecimal("1e+#{length}")
    Time.at(ts)
  end
end
