class File
  # Gives the size of a file as a string including the unit. It will choose the
  # unit to use based on how big the file is. Decimals will be rounded to the
  # tenths. +size+ is either a Numeric containing the size in bytes, a File
  # object, or a String with the name of the file.
  #
  # @example Calculates size from several numbers
  #   File.human_size 120         # => "120 Bytes"
  #   File.human_size 1234        # => "1.2 KB"
  #   File.human_size 1234567     # => "1.2 MB"
  #   File.human_size 1234567890  # => "1.1 GB"
  #
  # @example Calculates the size of a 3 kilobyte file "foo.txt"
  #   File.human_size "foo.txt"  # => "3 KB"
  #
  # @see File#human_size
  #
  # @param [String, File, Numeric] size the file to measure or size in bytes
  # @return [String] the human readable size
  def self.human_size(size)
    bytes = size.is_a?(Numeric) ? size : File.size(size) rescue nil

    return "Empty" if bytes.blank? || bytes.zero?
    return "1 Byte" if bytes == 1

    divisor, unit =
      if bytes < Numeric::KILOBYTE
        [1, "Bytes"]
      elsif bytes < Numeric::MEGABYTE
        [Numeric::KILOBYTE, "KB"]
      elsif bytes < Numeric::GIGABYTE
        [Numeric::MEGABYTE, "MB"]
      else
        [Numeric::GIGABYTE, "GB"]
      end

    "%g #{unit}" % (bytes.to_f / divisor).round(1)
  end

  # Returns the human readable form of the file's size.
  #
  # @example Calculates the size of a 4.2 megabyte file object
  #   f.human_size  # => "4.2 MB"
  #
  # @see File::human_size
  #
  # @return [String] the human readable size
  def human_size
    File.human_size self
  end
end
