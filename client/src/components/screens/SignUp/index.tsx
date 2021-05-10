import { FormHandles } from "@unform/core";
import { useCallback, useRef } from "react";
import { Link, useHistory } from "react-router-dom";
import * as Yup from "yup";
import { ISignUp } from "../../../libs/interfaces/screens";
import { signUp } from "../../../libs/validations";
import { getValidationErrors } from "../../../utils";
import { Button, Input } from "../../atoms";
import { FormContainer } from "../../molecules";
import { Container } from "./styles";

const SignUp: React.FC = () => {
  const formRef = useRef<FormHandles>(null);

  const history = useHistory();

  const handleSubmit = useCallback(async (data: ISignUp): Promise<void> => {
    try {
      formRef.current?.setErrors({});

      await signUp.validate(data, {
        abortEarly: false,
      });

      // await signUp({
      //   email: data.email,
      //   password: data.password,
      // });

      history.push("/signed");
    } catch (error) {
      if (error instanceof Yup.ValidationError) {
        const errors = getValidationErrors(error);
        formRef.current?.setErrors(errors);

        return;
      }

      // addToast({
      //   type: "error",
      //   title: "Erro na autenticação",
      //   description: "Ocorreu um erro ao fazer login, cheque as credenciais.",
      // });
    }
  }, []);

  return (
    <Container>
      <FormContainer formRef={formRef} handleSubmit={handleSubmit}>
        <Input name="email" label="Email" required />
        <Input name="password" label="Password" required />
        <Input name="confirmPassword" label="Confirm Password" required />
        <Button text="PLAY NOW!" clickFunction={() => {}} />
        <Link to="/">Already have an account? Sign In</Link>
      </FormContainer>
    </Container>
  );
};

export default SignUp;
