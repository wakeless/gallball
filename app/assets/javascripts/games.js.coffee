# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#game_sport_id").val $.cookie("sport") || 1
  $("#game_winner_id").val $.cookie("winner")
  $('#game_sport_id, #game_winner_id, #game_loser_id').chosen({'search_contains': true})
  $('#new_game_modal').modal('hide')

  $('#new_game_modal').on 'shown', ->
     $('#game_loser_id_chzn .chzn-single:first').focus()

  # force focus on something else other than a chosen field, otherwise there's a bug on the field when re-opening the modal
  $('#new_game_modal').on 'hide', ->
     $('#close_create_game').focus()

  $("form#new_game").submit (f) ->
    $.cookie "sport", $("#game_sport_id").val(), { expires: 365 }
    $.cookie "winner", $("#game_winner_id").val(), { expires: 365 }

  $('.chzn-single').focus (e) ->
    e.preventDefault()

  $('#create_game').click ->
    $('#new_game').submit()

  $('body').keyup (e) ->
    if e.keyCode == 78 # 'n' key
      $('#new_game_modal').modal('show')
