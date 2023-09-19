import Layout from "src/core/layouts/Layout"
import { BlitzPage } from "@blitzjs/next"
import { VStack } from "@chakra-ui/react"
import FunctionCard from "src/core/components/FunctionCard"

const Home: BlitzPage = () => {
  return (
    <Layout title="Home">
      <VStack spacing={4} px={6} w="100%">
        <FunctionCard
          name="Thermodynamic Properties"
          description="For air & combustion products"
          route="thermo-properties"
        />
        <FunctionCard
          name="Shockwave Calculator"
          description="Calculate post-shock properties"
          route="shockwave-calculator"
        />
      </VStack>
    </Layout>
  )
}

export default Home
