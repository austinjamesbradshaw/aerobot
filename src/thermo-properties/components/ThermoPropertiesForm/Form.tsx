import Form from "src/core/components/Form"
import ThermoPropertiesFormInputs from "./FormInputs"
import { ThermoPropertiesSchema } from "src/thermo-properties/schemas"
import { useMutation } from "@blitzjs/rpc"
import calculateThermoProperties from "src/thermo-properties/mutations/calculateThermoProperties"

const ThermoPropertiesForm = () => {
  const [calculateThermoPropertiesMutation] = useMutation(calculateThermoProperties)
  return (
    <Form
      id="thermo-properties-form"
      onSubmit={async (values, form) => {
        const result = await calculateThermoPropertiesMutation(values)
        form.change("result", result)
      }}
      schema={ThermoPropertiesSchema}
      style={{ padding: 0, height: "100%", width: "100%", overflow: "scroll" }}
    >
      <ThermoPropertiesFormInputs />
    </Form>
  )
}

export default ThermoPropertiesForm
