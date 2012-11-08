class Numeric
  KILOBYTE = 1024
  MEGABYTE = KILOBYTE * 1024
  GIGABYTE = MEGABYTE * 1024
  TERABYTE = GIGABYTE * 1024
  PETABYTE = TERABYTE * 1024
  EXABYTE  = PETABYTE * 1024

  def bytes
    self
  end
  alias_method :byte, :bytes

  def kilobytes
    self * KILOBYTE
  end
  alias_method :kilobyte, :kilobytes

  def megabytes
    self * MEGABYTE
  end
  alias_method :megabyte, :megabytes

  def gigabytes
    self * GIGABYTE
  end
  alias_method :gigabyte, :gigabytes

  def terabytes
    self * TERABYTE
  end
  alias_method :terabyte, :terabytes

  def petabytes
    self * PETABYTE
  end
  alias_method :petabyte, :petabytes

  def exabytes
    self * EXABYTE
  end
  alias_method :exabyte, :exabytes
end
