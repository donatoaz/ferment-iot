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
    },{
      'id': 'g2'
      'bullet': 'square'
      'valueField': 'reference'
      'balloonText': '[[category]]: [[value]]'
      }
    ]
    'categoryField': 'measured_at'
    'categoryAxis':
      'parseDates': true
      'equalSpacing': true
      'dashLength': 1
      'minorGridEnabled': true
    'dataProvider': chartData)
    App.cable.subscriptions.create { channel: "SensorChannel", id: sensor_id },
      received: (data) ->
        ref = null
        $.ajax "/control_loops/#{control_loop_id}/reference",
          async: false,
          dataType: 'json',
          success: (response) ->
            ref = response.reference
        @addDataToChart data, ref

      addDataToChart: (data, reference) ->
        data['reference'] = reference
        console.log(data)
        if chartData.length > 200
          chartData.splice 0, chartData.length - 200
        chartData.push data
        chart.validateData()
