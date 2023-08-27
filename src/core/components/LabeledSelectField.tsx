import { FormControl, FormErrorMessage, FormLabel, Input, Select } from "@chakra-ui/react"
import { forwardRef, ComponentPropsWithoutRef, PropsWithoutRef } from "react"
import { useField, UseFieldConfig } from "react-final-form"

export interface LabeledSelectFieldProps
  extends Omit<PropsWithoutRef<JSX.IntrinsicElements["select"]>, "size"> {
  /** Field name. */
  name: string
  /** Field label. */
  label: string
  /** Field type. Doesn't include radio buttons and checkboxes */
  controlProps?: PropsWithoutRef<JSX.IntrinsicElements["div"]>
  labelProps?: ComponentPropsWithoutRef<"label">
  fieldProps?: UseFieldConfig<string>
  props?: object
}

export const LabeledSelectField = forwardRef<HTMLSelectElement, LabeledSelectFieldProps>(
  ({ name, label, controlProps, fieldProps, labelProps, ...props }, ref) => {
    const {
      input,
      meta: { touched, error, submitError, submitting },
    } = useField(name, {
      ...fieldProps,
    })

    const normalizedError = Array.isArray(error) ? error.join(", ") : error || submitError

    return (
      <FormControl {...controlProps} isInvalid={touched && normalizedError}>
        <FormLabel {...labelProps}>{label}</FormLabel>
        <Select {...input} isDisabled={submitting} {...props} ref={ref} />
        {touched && normalizedError && (
          <FormErrorMessage>
            {normalizedError.includes("Expected") ? "Required" : normalizedError}
          </FormErrorMessage>
        )}
      </FormControl>
    )
  }
)

export default LabeledSelectField
