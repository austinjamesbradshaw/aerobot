import { resolver } from "@blitzjs/rpc"
import { ShockwaveCalculatorSchema } from "../schemas"

export default resolver.pipe(
  resolver.zod(ShockwaveCalculatorSchema),
  async ({ gamma, M1, theta, p1, T1, rho1 }) => {
    const beta = calculateBeta(M1, theta, gamma)
    const M1n = calculateM1n(M1, beta)
    const M2n = calculateM2n(gamma, M1n)
    const M2 = calculateM2(M2n, beta, theta)
    const p2 = calculateP2(p1, gamma, M1)
    const T2 = calculateT2(T1, gamma, M1)
    const rho2 = calculateRho2(gamma, M1)

    return { gamma, M1, theta, p1, T1, rho1, beta, M1n, M2n, M2, p2, T2, rho2 }
  }
)

const calculateBeta = (M1, thetaInDeg, gamma) => {
  const pi = Math.PI
  const theta = (thetaInDeg * pi) / 180
  const initGuess = theta

  function f(beta) {
    return (
      Math.tan(theta) -
      ((2 / Math.tan(beta)) * (Math.pow(M1, 2) * Math.pow(Math.sin(beta), 2) - 1)) /
        (Math.pow(M1, 2) * (gamma + Math.cos(2 * beta)) + 2)
    )
  }

  function derivative(f) {
    const h = 0.001
    return function (x) {
      return (f(x + h) - f(x - h)) / (2 * h)
    }
  }

  const precision = 0.001
  let prevGuess = 0

  function newtonsMethod(guess) {
    if (guess === null || guess === undefined) guess = 0

    if (Math.abs(prevGuess - guess) > precision) {
      prevGuess = guess
      const approx = guess - f(guess) / derivative(f)(guess)

      return newtonsMethod(approx)
    } else {
      return (guess * 180) / pi
    }
  }

  const beta = newtonsMethod(initGuess)
  return beta
}

const calculateM1n = (M1, beta) => M1 * Math.sin((beta * Math.PI) / 180)

const calculateM2n = (gamma, M1n) =>
  Math.sqrt((2 + (gamma - 1) * Math.pow(M1n, 2)) / (2 * gamma * Math.pow(M1n, 2) - (gamma - 1)))

const calculateM2 = (M2n, beta, theta) => M2n / Math.sin(((beta - theta) * Math.PI) / 180)

const calculateP2 = (p1, gamma, M1) =>
  p1 * (1 + ((2 * gamma) / (gamma + 1)) * (Math.pow(M1, 2) - 1))

const calculateT2 = (T1, gamma, M1) =>
  T1 *
  (1 + ((2 * gamma) / (gamma + 1)) * (Math.pow(M1, 2) - 1)) *
  ((2 + (gamma - 1) * Math.pow(M1, 2)) / ((gamma + 1) * Math.pow(M1, 2)))

const calculateRho2 = (gamma, M1) =>
  ((gamma + 1) * Math.pow(M1, 2)) / (2 + (gamma - 1) * Math.pow(M1, 2))
