import { FormHandles } from "@unform/core";
import { useCallback, useRef } from "react";
import { Link, useHistory } from "react-router-dom";
import * as Yup from "yup";
import { Button, Input } from "../../atoms";
import { FormContainer } from "../../molecules";
import { Container } from "./styles";
import { signIn } from "../../../libs/validations/";
import { ISignIn } from "../../../libs/interfaces/screens";
import { getValidationErrors } from "../../../utils";

const SignIn: React.FC = () => {
  const formRef = useRef<FormHandles>(null);

  const history = useHistory();

  const handleSubmit = useCallback(async (data: ISignIn): Promise<void> => {
    try {
      formRef.current?.setErrors({});

      await signIn.validate(data, {
        abortEarly: false,
      });

      // await signIn({
      //   email: data.email,
      //   password: data.password,
      // });

      history.push("/gamelog");
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
        <Button text="PLAY NOW!" clickFunction={() => {}} />
        <Link to="signup">Do not have an account? Sign Up</Link>
      </FormContainer>
    </Container>
  );
};

export default SignIn;
