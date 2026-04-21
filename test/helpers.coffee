import { pipe, tee } from "@dashkite/joy/function"
import * as K from "@dashkite/katana"
import Mimic from "@dashkite/mimic"

import configuration from "./configuration"

export start = pipe [
    Mimic.browser
    Mimic.context
    Mimic.page
    Mimic.console Mimic.report.console
    Mimic.error Mimic.report.error
    Mimic.goto configuration.url
    Mimic.wait()
  ]

export finish = pipe [
  K.down
  Mimic.close
]

export runner = ( test ) -> ->
  try
    stack = await start()
    await test stack
  catch error
    throw error
  finally
    finish stack if stack?

export view = ( name ) ->
  Mimic.waitFor ".active.page[data-name='#{ name }']"
