themeChanger = ->
  document.addEventListener "click", ( event ) ->
    if event.target?.parentElement?.matches ".themes"
      document.body.className = event.target.className

if document.readyState == "loading"
  document.addEventListener "DOMContentLoaded", themeChanger
else
  themeChanger()