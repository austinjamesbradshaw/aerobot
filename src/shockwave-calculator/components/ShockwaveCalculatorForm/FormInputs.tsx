import LabeledTextField from "src/core/components/LabeledTextField"
import { VStack } from "@chakra-ui/react"

const ShockwaveCalculatorFormInputs = () => {
  return (
    <VStack h="100%" w="100%" p={6} overflow="scroll" spacing={4}>
      <LabeledTextField name="gamma" label="γ" />
      <LabeledTextField name="M1" label="M1" />
      <LabeledTextField name="theta" label="θ [deg]" />
      <LabeledTextField name="p1" label="p1" />
      <LabeledTextField name="T1" label="T1" />
      <LabeledTextField name="rho1" label="ρ1" />
      <LabeledTextField
        name="beta"
        label="β [deg]"
        disabled={true}
        props={{ variant: "filled" }}
        variant="filled"
        style={{ opacity: "1" }}
      />
      <LabeledTextField
        name="p2"
        label="p2"
        disabled={true}
        variant="filled"
        style={{ opacity: "1" }}
      />
      <LabeledTextField
        name="T2"
        label="T2"
        disabled={true}
        variant="filled"
        style={{ opacity: "1" }}
      />
      <LabeledTextField
        name="rho2"
        label="ρ2"
        disabled={true}
        variant="filled"
        style={{ opacity: "1" }}
      />
      <LabeledTextField
        name="M1n"
        label="M1n"
        disabled={true}
        variant="filled"
        style={{ opacity: "1" }}
      />
      <LabeledTextField
        name="M2n"
        label="M2n"
        disabled={true}
        variant="filled"
        style={{ opacity: "1" }}
      />
      <LabeledTextField
        name="M2"
        label="M2"
        disabled={true}
        variant="filled"
        style={{ opacity: "1" }}
      />
    </VStack>
  )
}

export default ShockwaveCalculatorFormInputs
