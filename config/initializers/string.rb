class String
  def strip_multiline_string_indentation
    return self unless self =~ /\A *\n( *)/
    indent = $1
    gsub(/\A\s*|^#{indent}/, '')
  end
end
