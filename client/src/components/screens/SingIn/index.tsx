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
import { useAuth } from "../../../hooks";
import Swal from "sweetalert2";

const SignIn: React.FC = () => {
  const formRef = useRef<FormHandles>(null);

  const history = useHistory();

  const { loading, setLoading, createAuth, isAuthenticated } = useAuth();

  const handleSubmit = useCallback(async (data: ISignIn): Promise<void> => {
    try {
      formRef.current?.setErrors({});

      await signIn.validate(data, {
        abortEarly: false,
      });

      const response = await createAuth({
        email: data.email,
        password: data.password,
      });

      if (response.success && response.data.token) {
        history.push("/");
        return;
      }

      Swal.fire("Error...", response.errors, "error");
    } catch (error) {
      if (error instanceof Yup.ValidationError) {
        const errors = getValidationErrors(error);
        formRef.current?.setErrors(errors);

        return;
      } else {
        Swal.fire("Error...", "Something went wrong!", "error");
      }
    } finally {
      setLoading(false);
    }
  }, []);

  return (
    <Container>
      <FormContainer formRef={formRef} handleSubmit={handleSubmit}>
        <Input name="email" label="Email" required />
        <Input name="password" label="Password" required />
        <Button text="PLAY NOW!" loading={loading} />
        <Link to="signup">Do not have an account? Sign Up</Link>
      </FormContainer>
    </Container>
  );
};

export default SignIn;
