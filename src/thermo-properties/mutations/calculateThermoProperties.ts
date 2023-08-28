import { resolver } from "@blitzjs/rpc"
import { ThermoPropertiesSchema } from "../schemas"
const { spawn } = require("child_process")

export default resolver.pipe(resolver.zod(ThermoPropertiesSchema), async (input) => {
  let result = await runExec(input)

  var reg = /&(.*?)&/
  console.log(result.split(reg)[1])
  if (result.split(reg)[1] == undefined) {
    result = "Error, please check inputs."
  } else {
    result = result.split(reg)[1]
  }

  return result
})

async function runExec(formData): Promise<string> {
  console.log("Started runExec function...")
  return await new Promise((resolve, reject) => {
    const program = "./example"

    const child = spawn(program, {
      cwd: `src/thermo-properties/${
        process.env.NODE_ENV === "production" ? "/prod-thermo-tables" : "/dev-thermo-tables"
      }`,
    })
    let result = ""

    child.stdout.on("error", function (err) {
      reject(err)
    })

    child.stdout.on("data", (data) => {
      console.log("Pushing result..")
      result += data.toString()
    })

    child.stdout.on("close", (code) => {
      console.log("Exe closed..")
      resolve(result)
    })

    Object.values(formData).forEach((input) => {
      if (input !== "" && input !== undefined) {
        console.log("Pushing input:", input)
        child.stdin.write(input + "\n")
      }
    })
  })
}
