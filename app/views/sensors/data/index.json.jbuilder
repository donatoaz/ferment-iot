#json.array! @data, partial: 'sensors/data/datum', as: :datum
json.array! @data do |datum|
  json.measured_at_formatted datum.measured_at_formatted
  json.value datum.value
end
