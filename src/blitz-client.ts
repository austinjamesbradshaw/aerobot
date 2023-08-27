import { setupBlitzClient } from "@blitzjs/next"
import { BlitzRpcPlugin } from "@blitzjs/rpc"

const { withBlitz } = setupBlitzClient({
  plugins: [BlitzRpcPlugin({})],
})

export { withBlitz }
