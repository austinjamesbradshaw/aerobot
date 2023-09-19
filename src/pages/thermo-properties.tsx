import Layout from "src/core/layouts/Layout"
import { BlitzPage } from "@blitzjs/next"
import ThermoPropertiesFooter from "src/thermo-properties/components/ThermoPropertiesFooter"
import ThermoPropertiesHeader from "src/thermo-properties/components/ThermoPropertiesHeader"
import ThermoPropertiesForm from "src/thermo-properties/components/ThermoPropertiesForm"

const ThermoProperties: BlitzPage = () => {
  return (
    <Layout title="Thermo Properties">
      <ThermoPropertiesHeader />
      <ThermoPropertiesForm />
      <ThermoPropertiesFooter />
    </Layout>
  )
}

export default ThermoProperties
