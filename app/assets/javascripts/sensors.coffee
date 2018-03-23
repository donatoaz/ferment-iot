# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  sensor_id = $('#sensor-readings').data('sensor-id')
  console.log 'Streaming data for sensor #' + sensor_id
  chartData = []
  chart = AmCharts.makeChart('chart',
  'type': 'serial'
  'theme': 'light'
  'dataDateFormat': 'YYYY-MM-DD'
  'valueAxes': [ {
    'id': 'v1'
    'position': 'left'
  } ]
  'graphs': [ {
    'id': 'g1'
    'bullet': 'round'
    'valueField': 'value'
    'balloonText': '[[category]]: [[value]]'
  } ]
  'categoryField': 'created_at'
  'categoryAxis':
    'parseDates': true
    'equalSpacing': true
    'dashLength': 1
    'minorGridEnabled': true
  'dataProvider': chartData)
  App.cable.subscriptions.create { channel: "SensorChannel", id: sensor_id },
    received: (data) ->
      @addDataToChart data
      @appendLine data

    addDataToChart: (data) ->
      chartData.push data
      chart.validateData()
   
    appendLine: (data) ->
      html = @createLine(data)
      $('#sensor-readings').append(html)
   
    createLine: (data) ->
      """
      <div class="sensor-reading">
        <span class="timestamp">#{data["created_at"]}</span>
        <span class="value">#{data["value"]}</span>
      </div>
      """
