# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  control_loop_id = $('#control-loop').data('control-loop-id')
  sensor_id = $('#control-loop').data('sensor-id')
  if control_loop_id && sensor_id
    console.log 'Streaming data for control_loop #' + control_loop_id
    chartData = []
    chart = AmCharts.makeChart('chart',
    'pathToImages': '/assets/'
    'type': 'serial'
    'theme': 'light'
    'dataDateFormat': 'YYYY-MM-DD JJ:NN:SS'
    'valueAxes': [ {
      'id': 'v1'
      'position': 'left'
    } ]
    'graphs': [ {
      'id': 'g1'
      #'type': 'smoothedline'
      'bullet': 'round'
      'valueField': 'value'
      'balloonText': '[[value]]'
    },{
      'id': 'g2'
      #'type': 'smoothedline'
      'bullet': 'square'
      'valueField': 'reference_value'
      'balloonText': '[[value]]'
    } ]
    'chartScrollbar': {
      'graph': 'g1'
      'oppositeAxis': false
      'offset': 30
      'scrollbarHeight': 80
      'backgroundAlpha': 0
      'selectedBackgroundAlpha': 0.2
      'selectedBackgroundColor': '#888888'
      'graphFillAlpha': 0
      'graphLineAlpha': 0.5
      'selectedGraphFillAlpha': 0
      'selectedGraphLineAlpha': 1
      'autoGridCount': true
      'color': '#000000'
      'graphLineColor': '#FF0000'
    }
    'chartCursor': {
      'pan': true
      'valueLineEnabled': true
      'valueLineBalloonEnabled': true
      'cursorAlpha':1
      'cursorColor':'#258cbb'
      'limitToGraph':'g1'
      'valueLineAlpha':0.2
      'valueZoomable':true
    }
    'categoryField': 'measured_at_formatted'
    'categoryAxis':
      'parseDates': true
      'minPeriod': 'ss',
      'dashLength': 1
      'minorGridEnabled': true
    'dataProvider': chartData)
    $.getJSON "/control_loops/#{control_loop_id}/data"
    .then (response) ->
      chartData.push.apply(chartData, response['sensor_data'].reverse())
      chartData.push.apply(chartData, response['reference_data'])
      chartData.sort (a, b) ->
        if a.measured_at_formatted > b.measured_at_formatted
          1
        else
          -1
      chart.validateData()
    .catch (error) ->
      console.log "Error getting sensor data #{sensor_id}"
      console.log error
    App.cable.subscriptions.create { channel: "SensorChannel", id: sensor_id },
      received: (data) ->
        @addDataToChart data

      addDataToChart: (data) ->
        chartData.push data
        chartData.sort (a, b) ->
          if a.measured_at_formatted > b.measured_at_formatted
            1
          else
            -1
        chart.validateData()
