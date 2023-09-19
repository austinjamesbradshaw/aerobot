import Layout from "src/core/layouts/Layout"
import { BlitzPage } from "@blitzjs/next"
import ShockwaveCalculatorForm from "src/shockwave-calculator/components/ShockwaveCalculatorForm/Form"
import ShockwaveCalculatorHeader from "src/shockwave-calculator/components/ShockwaveCalculatorHeader"
import ShockwaveCalculatorFooter from "src/shockwave-calculator/components/ShockwaveCalculatorFooter"

const ShockwaveCalculator: BlitzPage = () => {
  return (
    <Layout title="Shockwave Calculator">
      <ShockwaveCalculatorHeader />
      <ShockwaveCalculatorForm />
      <ShockwaveCalculatorFooter />
    </Layout>
  )
}

export default ShockwaveCalculator
