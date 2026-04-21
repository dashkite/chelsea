import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"
import { runner } from "./helpers"
import scenarios from "./scenarios"

do ->
  print await test "Chelsea Application (HX)", (
    for category, cases of scenarios
      test category, (
        test name, runner pipeline for name, pipeline of cases
      )
  )

  process.exit if success then 0 else 1
