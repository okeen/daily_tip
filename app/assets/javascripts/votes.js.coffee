$ ->
  $(".vote_button").click (e)->
    vote_button = $(@)
    url = vote_button.data "target"
    $.post url, (response, state) =>
      if state == "success"
        console.log "Voted OK"
        vote_button.addClass "active"
        vote_button.siblings().removeClass "active"
        $("#tip_votes .after_vote_message").html response
      else
        console.log "Vote error"
