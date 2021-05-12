import { ValidationError } from "yup";

export type FormErrors = { [key: string]: string };

export default function getValidationErrors(
  errors: ValidationError
): FormErrors {
  const validationErrors: FormErrors = {};

  errors.inner.forEach((error) => {
    if (error.path) {
      validationErrors[error.path] = error.message;
    }
  });

  return validationErrors;
}
