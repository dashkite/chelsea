import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"
import { once } from "@dashkite/joy/function"
import Mimic from "@dashkite/mimic"

import auth from "./cases/auth"
import dashboard from "./cases/dashboard"
import editor from "./cases/editor"
import identity from "./cases/identity"

do ->
  start = once Mimic.browser
  try
    print await test "Chelsea Application (HX)", [
      auth start
      dashboard start
      editor start
      identity start
    ]
  finally
    [ browser ] = await start()
    await browser.close()

  process.exit if success then 0 else 1
