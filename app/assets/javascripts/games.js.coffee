# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#new_game_modal').modal('hide')

  $('#new_game_modal').on 'shown', ->
    $("#game_sport_id").val(1)
    $('#game_sport_id, #game_winner_id, #game_loser_id').chosen({'search_contains': true})

    $('.chzn-single').focus (e) ->
      e.preventDefault()
    
    $('.chzn-single:first').focus()

  $('#create_game').click ->
    $('#new_game').submit()

  $('body').keyup (e) ->
    if e.keyCode == 78
      $('#new_game_modal').modal('show')
