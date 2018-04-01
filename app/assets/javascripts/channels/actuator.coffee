$(document).on 'turbolinks:load', ->
  actuator_id = $('#actuator').data('actuator-id')
  if actuator_id
    console.log 'Monitoring status of actuator #' + actuator_id
    App.actuator = App.cable.subscriptions.create { channel: "ActuatorChannel", id: actuator_id },
      connected: ->
        # Called when the subscription is ready for use on the server
        console.log 'Connected to actuators channel'

      disconnected: ->
        # Called when the subscription has been terminated by the server
        console.log 'Disconnected from actuators channel'

      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        console.log 'Received data from ActuatorChannel:'
        console.log data
        @updateStatusDiv data

      updateStatusDiv: (data) ->
        html = @createStatusElement data
        $('#actuator').html(html)

      createStatusElement: (data) ->
        """
        <span>#{data}</span>
        """
