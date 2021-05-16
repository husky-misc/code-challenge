import * as Yup from "yup";

export const signUp = Yup.object().shape({
  email: Yup.string().email().required("Email is required!"),
  password: Yup.string().required("Password is required!"),
  confirmPassword: Yup.string()
    .required("Confirmation is required!")
    .oneOf([Yup.ref("password"), ""], "passwords must match"),
});

export default signUp;
