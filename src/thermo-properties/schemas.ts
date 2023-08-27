import { z } from "zod"

export const ThermoPropertiesSchema = z.object({
  gasType: z.preprocess(Number, z.number()),
  function: z.preprocess(Number, z.number()),
  mixtureDefinition: z.preprocess(Number, z.number()).optional(),
  lambda: z.preprocess(Number, z.number()).optional(),
  phi: z.preprocess(Number, z.number()).optional(),
  T: z.preprocess(Number, z.number()).optional(),
  h: z.preprocess(Number, z.number()).optional(),
  p: z.preprocess(Number, z.number()).optional(),
  s: z.preprocess(Number, z.number()).optional(),
})
