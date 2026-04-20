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
    login "test@example.com", configuration.url
  ]

  test "Blog Identity", [

    test "Navigate to Edit Blog", pipe [
      preamble
      tee pipe [
        Mimic.waitFor "nav"
        Mimic.select "nav a:nth-child(2)"
        Mimic.click
      ]
      Mimic.wait()
      view "edit blog"
      ([ browser, context ]) -> context.close()
    ]

  ]
