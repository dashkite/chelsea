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

  test "Post Editor", [

    test "Add Post Redirection", pipe [
      preamble
      tee pipe [
        Mimic.waitFor "posts-view"
        Mimic.select "posts-view"
        Mimic.waitForShadow
        Mimic.shadow
        Mimic.waitFor "button[name='add post']"
        Mimic.select "button[name='add post']"
        Mimic.click
      ]
      Mimic.wait()
      view "edit post"
      Mimic.evaluate -> window.location.href
      K.peek ( url ) ->
        assert url.includes "/post/"
      ([ browser, context ]) -> context.close()
    ]

  ]
