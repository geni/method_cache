module PoolMethods
  def pool=(hash)
    @pool = hash
  end

  def pool
    @pool ||= {}
  end
end