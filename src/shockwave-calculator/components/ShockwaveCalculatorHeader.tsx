import { Image, Text, VStack } from "@chakra-ui/react"

const ShockwaveCalculatorHeader = () => {
  return (
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
  )
}

export default ShockwaveCalculatorHeader
