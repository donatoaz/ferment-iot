json.sensor_data @sensor_data do |datum|
  json.measured_at_formatted datum.measured_at_formatted
  json.value datum.value 
end

json.reference_data @reference_trackings do |rt|
  json.measured_at_formatted rt.target_datetime.strftime('%Y-%m-%d %H:%M:%S')
  json.reference_value rt.value
end
