import Layout from "src/core/layouts/Layout"
import { BlitzPage } from "@blitzjs/next"
import { Box, Button, Flex, Image, Text, VStack } from "@chakra-ui/react"
import Form from "src/core/components/Form"
import LabeledTextField from "src/core/components/LabeledTextField"
import { useMutation } from "@blitzjs/rpc"
import calculateShockwave from "src/shockwave/mutations/calculateShockwave"
import { ShockwaveCalculatorSchema } from "src/shockwave/schemas"

const ShockwaveCalculator: BlitzPage = () => {
  const [calculateShockwaveMutation] = useMutation(calculateShockwave)
  return (
    <Layout title="Shockwave Calculator">
      <VStack spacing={0} w="100%" boxShadow="sm">
        <VStack align="left" px={6} spacing={0}>
          <Text fontSize="xl" fontWeight="bold">
            Shockwave Calculator
          </Text>
          <Text fontSize="xs" color="gray.500">
            Enter the pre-shock properties to compute the post-shock properties.
          </Text>
        </VStack>
        <Image src="shock.svg" px={12} />
      </VStack>
      <Form
        id="shockwave-form"
        onSubmit={async (values, form) => {
          const response = await calculateShockwaveMutation(values)
          Object.entries(response).map(([key, value]) => form.change(key, value))
        }}
        schema={ShockwaveCalculatorSchema}
        style={{ padding: 0, height: "100%", width: "100%", overflow: "scroll" }}
      >
        <VStack h="100%" w="100%" px={6} overflow="scroll" spacing={4}>
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
      </Form>
      <Flex px={6} py={4} w="100%" borderTop="1px" borderColor="gray.200">
        <Button
          boxShadow="xl"
          colorScheme="orange"
          onClick={() =>
            document
              .getElementById("shockwave-form")
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

export default ShockwaveCalculator
