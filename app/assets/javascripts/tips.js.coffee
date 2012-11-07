$ ->
  $('#tip_content').wysihtml5 link: false, image: false

  $(".link_show_inline").click (e)=>
    e.preventDefault()
    open_inline_button = $ e.target
    container_link = $(open_inline_button).closest(".link")
    link_id = container_link.data('link_id')
    console.log "Opening #{link_id} inline"

    iframe_container = container_link.find ".link_iframe_container"
    iframe_container.html("Loading...")
    iframe_container.show()

    $.get "/readability/#{link_id}", {}, (response, status) =>

      iframe_container.html response

      close_button = container_link.find(".link_close").clone()
      close_button.click (e)=>
        e.preventDefault()
        close_inline_button = $ e.target
        container_link = $(close_inline_button).closest(".link")
        iframe_container = container_link.find ".link_iframe_container"
        iframe_container.html("")
        iframe_container.hide()

      close_button.removeClass "hide"
      iframe_container.children().before close_button

  $(".link_close")

