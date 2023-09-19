import { Flex, Button } from "@chakra-ui/react"

const ShockwaveCalculatorFooter = () => {
  return (
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
  )
}

export default ShockwaveCalculatorFooter
