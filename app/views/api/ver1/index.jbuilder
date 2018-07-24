# unless @result.empty?
# unless results.empty?
unless @results.empty?
  json.set! :result do
    # json.array! @result, :card, :hand, :best
    # json.array! results, :card, :hand, :best
    json.array! @results, :card, :hand, :best
  end
end

unless @errors.empty?
# unless errors.empty?
  json.set! :error do
    json.array! @errors
    # json.array! errors
  end
end
