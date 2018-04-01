# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  sensor_id = $('#sensor-readings').data('sensor-id')
  if sensor_id
    console.log 'Streaming data for sensor #' + sensor_id
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
    chart.ignoreZoomed = false
    chart.addListener 'zoomed', (event) ->
      if chart.ignoreZoomed
        chart.ignoreZoomed = false
      else
        chart.zoomStartDate = event.startDate
        chart.zoomEndDate = event.endDate
    chart.addListener 'dataUpdated', (event) ->
      if chart.zoomStartDate && chart.zoomEndDate
        the_end_date = new Date()
        chart.zoomEndDate = the_end_date
        chart.zoomToDates chart.zoomStartDate, the_end_date
    $.getJSON "/sensors/#{sensor_id}/data"
    .then (response) ->
      chartData.push.apply(chartData, response.reverse())
      chartData.sort (a, b) ->
        new Date(a.measured_at_formatted).getTime() - new Date(b.measured_at_formatted).getTime()
      chart.validateData()
      end = new Date()
      start = new Date()
      start.setDate(end.getDate()-1)
      chart.zoomToDates(start, end)
    .catch (error) ->
      console.log "Error getting sensor data #{sensor_id}"
      console.log error
    App.cable.subscriptions.create { channel: "SensorChannel", id: sensor_id },
      received: (data) ->
        @addDataToChart data

      addDataToChart: (data) ->
        chartData.push data
        chartData.sort (a, b) ->
          new Date(a.measured_at_formatted).getTime() - new Date(b.measured_at_formatted).getTime()
        chart.ignoreZoomed = true
        chart.validateData()
        return
