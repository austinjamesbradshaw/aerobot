import Form from "src/core/components/Form"
import { useMutation } from "@blitzjs/rpc"
import calculateShockwave from "src/shockwave-calculator/mutations/calculateShockwave"
import { ShockwaveCalculatorSchema } from "src/shockwave-calculator/schemas"
import ShockwaveCalculatorFormInputs from "./FormInputs"

const ShockwaveCalculatorForm = () => {
  const [calculateShockwaveMutation] = useMutation(calculateShockwave)

  return (
    <Form
      id="shockwave-form"
      onSubmit={async (values, form) => {
        const response = await calculateShockwaveMutation(values)
        Object.entries(response).map(([key, value]) => form.change(key, value))
      }}
      schema={ShockwaveCalculatorSchema}
      style={{ padding: 0, height: "100%", width: "100%", overflow: "scroll" }}
    >
      <ShockwaveCalculatorFormInputs />
    </Form>
  )
}

export default ShockwaveCalculatorForm
