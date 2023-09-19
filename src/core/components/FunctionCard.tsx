import { HStack, VStack, Icon, Text } from "@chakra-ui/react"
import { useRouter } from "next/router"
import { FiChevronRight } from "react-icons/fi"

const FunctionCard = ({ name, description, route }) => {
  const router = useRouter()
  return (
    <HStack
      as="button"
      bg="white"
      _hover={{ bg: "gray.50" }}
      _active={{
        bg: "gray.100",
        transform: "scale(0.98)",
        boxShadow: "none",
      }}
      borderColor="gray.200"
      borderRadius="lg"
      borderWidth="1px"
      cursor="pointer"
      justify="space-between"
      onClick={() => router.push(route)}
      p={6}
      transition="all 0.2s cubic-bezier(.08,.52,.52,1)"
      w="100%"
    >
      <VStack align="left" spacing={0} textAlign="left">
        <Text fontSize="md" fontWeight="bold">
          {name}
        </Text>
        <Text fontSize="sm" color="gray.500">
          {description}
        </Text>
      </VStack>
      <Icon as={FiChevronRight} />
    </HStack>
  )
}

export default FunctionCard
