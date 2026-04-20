import { pipe, tee } from "@dashkite/joy/function"
import * as K from "@dashkite/katana"
import Mimic from "@dashkite/mimic"

export login = ( email, url ) ->
  pipe [
    Mimic.goto url
    Mimic.wait()

    tee pipe [
      # Wait for and fill in the connector
      Mimic.waitFor "email-connector"
      Mimic.select "email-connector"
      Mimic.waitForShadow
      Mimic.shadow

      tee pipe [
        Mimic.waitFor "form-field"
        Mimic.select "form-field"
        Mimic.waitForShadow
        Mimic.shadow
        Mimic.waitFor "input"
        Mimic.select "input"
        Mimic.type email
      ]

      Mimic.waitFor "button"
      Mimic.select "button"
      Mimic.click
    ]
    
    view "view posts"
  ]

export view = ( name ) ->
  Mimic.waitFor ".active.page[data-name='#{ name }']"
