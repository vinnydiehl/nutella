class Numeric
  # Formats a number as a currency string.
  #
  # @param [Hash] opts the options hash
  # @option opts [String] :sign the currency sign
  # @option opts [Symbol] :position the position of the currency sign
  # @option opts [Integer] :precision amount of decimal places to display
  # @option opts [String] :separator the separator between the ones and tenths
  # @option opts [String] :delimiter the thousands delimiter
  # @option opts [Boolean] :pretty sets 0 precision for whole amounts
  #
  # @return [String] the number in a currency format
  def to_currency(opts = {})
    opts = {
      sign: "$",
      position: :left,
      precision: 2,
      separator: ".",
      delimiter: ",",
      pretty: false
    }.merge(opts)

    opts[:precision] = 0 if opts[:pretty] && (self - self.floor).round(3) < 0.005

    # Must round it outside also as the %f formatter always rounds down
    ("%.#{opts[:precision]}f" % self.round(opts[:precision])).
      # Apply thousands delimiter
      gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1#{opts[:delimiter]}").
      # Apply unit separator
      gsub(/\.(\d{#{opts[:precision]}})$/, "#{opts[:separator]}\\1").
      # Now put the sign on with #prepend or #concat depending on which side
      send(
        {left: :prepend, right: :concat}[opts[:position]],
        opts[:sign] || ""
      )
  end
end
