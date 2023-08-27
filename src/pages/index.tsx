import Layout from "src/core/layouts/Layout"
import { BlitzPage } from "@blitzjs/next"
import { Button, HStack, Icon, Text, VStack } from "@chakra-ui/react"
import { FiChevronRight } from "react-icons/fi"
import Link from "next/link"
import { useRouter } from "next/router"

const Home: BlitzPage = () => {
  return (
    <Layout title="Home">
      <VStack spacing={4} px={6} w="100%">
        <FunctionCard
          name="Shockwave Calculator"
          description="Calculate post-shock properties"
          route="shockwave-calculator"
        />
        <FunctionCard
          name="Thermodynamic Properties"
          description="For air & combustion products"
          route="thermo-properties"
        />
      </VStack>
    </Layout>
  )
}

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

export default Home
