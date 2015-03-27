 class Hash
  def rename_keys(mapping)
    result = {}
    self.map do |k,v|
      mapped_key = mapping[k] ? mapping[k] : k
      result[mapped_key] = v.kind_of?(Hash) ? v.rename_keys(mapping) : v
      result[mapped_key] = v.collect{ |obj| obj.rename_keys(mapping) if obj.kind_of?(Hash)} if v.kind_of?(Array)
    end
  result
 end
end