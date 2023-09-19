import { Text, VStack } from "@chakra-ui/react"

const ThermoPropertiesHeader = () => {
  return (
    <VStack spacing={0} w="100%" boxShadow="sm">
      <VStack align="left" px={6} pb={6} spacing={0}>
        <Text fontSize="xl" fontWeight="bold">
          Thermodynamic Properties
        </Text>
        <Text fontSize="xs" color="gray.500">
          Select a gas type and a function to calculate. Then input the required property to compute
          the result.
        </Text>
      </VStack>
    </VStack>
  )
}

export default ThermoPropertiesHeader
