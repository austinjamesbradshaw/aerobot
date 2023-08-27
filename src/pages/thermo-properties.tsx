import Layout from "src/core/layouts/Layout"
import { BlitzPage } from "@blitzjs/next"
import { Button, Flex, Text, VStack } from "@chakra-ui/react"
import { useMutation } from "@blitzjs/rpc"
import calculateThermoProperties from "src/thermo-properties/mutations/calculateThermoProperties"
import Form from "src/core/components/Form"
import { ThermoPropertiesSchema } from "src/thermo-properties/schemas"
import LabeledSelectField from "src/core/components/LabeledSelectField"
import LabeledTextField from "src/core/components/LabeledTextField"
import { useForm, useFormState } from "react-final-form"
import { useEffect, useState } from "react"

const ThermoProperties: BlitzPage = () => {
  const [calculateThermoPropertiesMutation] = useMutation(calculateThermoProperties)
  return (
    <Layout title="Thermo Properties">
      <VStack spacing={0} w="100%" boxShadow="sm">
        <VStack align="left" px={6} pb={6} spacing={0}>
          <Text fontSize="xl" fontWeight="bold">
            Thermodynamic Properties
          </Text>
          <Text fontSize="xs" color="gray.500">
            Select a gas type and a function to calculate. Then input the required property to
            compute the result.
          </Text>
        </VStack>
      </VStack>
      <Form
        id="thermo-properties-form"
        onSubmit={async (values, form) => {
          const result = await calculateThermoPropertiesMutation(values)
          form.change("result", result)
        }}
        schema={ThermoPropertiesSchema}
        style={{ padding: 0, height: "100%", width: "100%", overflow: "scroll" }}
      >
        <FormInputs />
      </Form>
      <Flex px={6} py={4} w="100%" borderTop="1px" borderColor="gray.200">
        <Button
          boxShadow="xl"
          colorScheme="orange"
          onClick={() =>
            document
              .getElementById("thermo-properties-form")
              .dispatchEvent(new Event("submit", { cancelable: true, bubbles: true }))
          }
          w="100%"
        >
          Compute
        </Button>
      </Flex>
    </Layout>
  )
}

const FormInputs = () => {
  const form = useForm()
  const formState = useFormState()
  useEffect(() => {
    form.change("result", undefined)
    form.change("mixtureDefinition", undefined)
  }, [formState.values.gasType])
  useEffect(() => {
    form.change("result", undefined)
    form.change("T", undefined)
    form.change("h", undefined)
    form.change("p", undefined)
    form.change("s", undefined)
  }, [formState.values.function])
  useEffect(() => {
    form.change("result", undefined)
    form.change("lambda", undefined)
    form.change("phi", undefined)
  }, [formState.values.mixtureDefinition])
  return (
    <VStack h="100%" w="100%" p={6} overflow="scroll" spacing={4}>
      <LabeledSelectField name="gasType" label="Gas Type" placeholder="Select...">
        <option value="0">Air</option>
        <option value="1">Combustion Products</option>
      </LabeledSelectField>
      <LabeledSelectField name="function" label="Function" placeholder="Select...">
        <option value="1">T(h)</option>
        <option value="2">T(p,s)</option>
        <option value="3">h(T)</option>
        <option value="4">h(p,s)</option>
        <option value="5">p(T,s)</option>
        <option value="6">p(h,s)</option>
        <option value="7">s(T,p)</option>
        <option value="8">s(h,p)</option>
      </LabeledSelectField>
      {formState.values.gasType === "1" && (
        <LabeledSelectField
          name="mixtureDefinition"
          label="Mixture Definition"
          placeholder="Select..."
        >
          <option value="0">Excess Air</option>
          <option value="1">Equivalence Ratio</option>
        </LabeledSelectField>
      )}
      {formState.values.mixtureDefinition === "0" && (
        <LabeledTextField label="&lambda;" name="lambda" />
      )}
      {formState.values.mixtureDefinition === "1" && <LabeledTextField label="&phi;" name="phi" />}
      {(formState.values.function === "3" ||
        formState.values.function === "5" ||
        formState.values.function === "7") && <LabeledTextField label="T [K]" name="T" />}
      {(formState.values.function === "1" ||
        formState.values.function === "6" ||
        formState.values.function === "8") && <LabeledTextField label="h [kJ/kg]" name="h" />}
      {(formState.values.function === "2" ||
        formState.values.function === "4" ||
        formState.values.function === "7" ||
        formState.values.function === "8") && <LabeledTextField label="p [kJ/kg]" name="p" />}
      {(formState.values.function === "2" ||
        formState.values.function === "4" ||
        formState.values.function === "5" ||
        formState.values.function === "6") && <LabeledTextField label="s [kJ/kg]" name="s" />}
      <LabeledTextField
        label="Result"
        name="result"
        disabled={true}
        variant="filled"
        style={{ opacity: "1" }}
      />
    </VStack>
  )
}

export default ThermoProperties
