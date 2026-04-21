import { pipe } from "@dashkite/joy/function"
import actions from "../actions"
import data from "./data"

scenarios = {}
for category, cases of data
  scenarios[category] = {}
  for name, steps of cases
    scenarios[category][name] = pipe ( actions[step] for step in steps )

export default scenarios
