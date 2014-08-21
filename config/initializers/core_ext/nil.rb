class NilClass
  def method_missing(*args)
    nil
  end
  
  def dup
    nil
  end
  
  def id
    nil
  end
  
  def to_str
    ''
  end
end
