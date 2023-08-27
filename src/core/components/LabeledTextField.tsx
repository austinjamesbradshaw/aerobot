import { FormControl, FormErrorMessage, FormLabel, Input } from "@chakra-ui/react"
import { forwardRef, ComponentPropsWithoutRef, PropsWithoutRef } from "react"
import { useField, UseFieldConfig } from "react-final-form"

export interface LabeledTextFieldProps
  extends Omit<PropsWithoutRef<JSX.IntrinsicElements["input"]>, "size"> {
  /** Field name. */
  name: string
  /** Field label. */
  label: string
  /** Field type. Doesn't include radio buttons and checkboxes */
  type?: "text" | "password" | "email" | "number"
  controlProps?: PropsWithoutRef<JSX.IntrinsicElements["div"]>
  labelProps?: ComponentPropsWithoutRef<"label">
  fieldProps?: UseFieldConfig<string>
  variant?: string
  props?: object
}

export const LabeledTextField = forwardRef<HTMLInputElement, LabeledTextFieldProps>(
  ({ name, label, controlProps, fieldProps, labelProps, ...props }, ref) => {
    const {
      input,
      meta: { touched, error, submitError, submitting },
    } = useField(name, {
      parse:
        props.type === "number"
          ? (Number as any)
          : // Converting `""` to `null` ensures empty values will be set to null in the DB
            (v) => (v === "" ? null : v),
      ...fieldProps,
    })

    const normalizedError = Array.isArray(error) ? error.join(", ") : error || submitError

    return (
      <FormControl {...controlProps} isInvalid={touched && normalizedError}>
        <FormLabel {...labelProps}>{label}</FormLabel>
        <Input {...input} isDisabled={submitting} {...props} ref={ref} />
        {touched && normalizedError && (
          <FormErrorMessage>
            {normalizedError.includes("Expected") ? "Required" : normalizedError}
          </FormErrorMessage>
        )}
      </FormControl>
    )
  }
)

export default LabeledTextField
