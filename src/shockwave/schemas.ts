import { z } from "zod"

export const ShockwaveCalculatorSchema = z.object({
  gamma: z.preprocess(Number, z.number()),
  M1: z.preprocess(Number, z.number()),
  theta: z.preprocess(Number, z.number()),
  p1: z.preprocess(Number, z.number()),
  T1: z.preprocess(Number, z.number()),
  rho1: z.preprocess(Number, z.number()),
})

export const ShockwaveCalculatorFormSchema = z.object({
  gamma: z.preprocess(Number, z.number()),
  M1: z.preprocess(Number, z.number()),
  theta: z.preprocess(Number, z.number()),
  p1: z.preprocess(Number, z.number()),
  T1: z.preprocess(Number, z.number()),
  rho1: z.preprocess(Number, z.number()),
})
