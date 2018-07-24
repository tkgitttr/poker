unless @results.empty?
  json.set! :result do
    json.array! @results, :card, :hand, :best
  end
end

unless @errors.empty?
  json.set! :error do
    json.array! @errors
  end
end
