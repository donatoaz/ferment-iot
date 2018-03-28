# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  actuator_id = $('#actuator').data('actuator-id')
  if actuator_id
    $.getJSON "/actuators/#{actuator_id}"
    .then (response) ->
      $('#actuator').html("<span>#{response.output}</span>")
    .catch (error) ->
      console.log "Error getting actuator #{actuator_id}"
      console.log error
