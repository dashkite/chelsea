import assert from "@dashkite/assert"
import { test } from "@dashkite/amen"
import { pipe, once, tee } from "@dashkite/joy/function"
import * as K from "@dashkite/katana"
import Mimic from "@dashkite/mimic"
import { login, view } from "../helpers"
import configuration from "../configuration"

export default ( start ) ->

  preamble = once pipe [
    start
    Mimic.context
    Mimic.page
    Mimic.console ( message ) -> console.log "BROWSER:", message.text()
    Mimic.error ( error ) -> console.error "BROWSER ERROR:", error.message
  ]

  test "Authentication", [

    test "Login Flow", pipe [
      preamble
      login "test@example.com", configuration.url
      # Verify submission logic ran
      tee pipe [
        Mimic.evaluate -> localStorage.getItem "connection"
        K.peek ( email ) -> assert.equal email, "test@example.com"
      ]
      view "view posts"
      ([ browser, context ]) -> context.close()
    ]

  ]
