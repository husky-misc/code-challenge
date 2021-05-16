import { FormHandles } from "@unform/core";
import { useCallback, useRef } from "react";
import { Link, useHistory } from "react-router-dom";
import Swal from "sweetalert2";
import * as Yup from "yup";
import { useAuth } from "../../../hooks";
import useUser from "../../../hooks/user";
import { ISignUp } from "../../../libs/interfaces/screens";
import { signUp } from "../../../libs/validations";
import { getValidationErrors } from "../../../utils";
import { Button, Input } from "../../atoms";
import { FormContainer } from "../../molecules";
import { Container } from "./styles";

const SignUp: React.FC = () => {
  const formRef = useRef<FormHandles>(null);

  const history = useHistory();
  const { loading, setLoading, createUser } = useUser();
  const { setIsAuthenticated } = useAuth();

  const handleSubmit = useCallback(async (data: ISignUp): Promise<void> => {
    try {
      formRef.current?.setErrors({});

      await signUp.validate(data, {
        abortEarly: false,
      });

      const response = await createUser({
        email: data.email,
        password: data.password,
      });

      if (response.data.token) {
        setIsAuthenticated(true);
        history.push("/signed");
      }
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
        <Input name="confirmPassword" label="Confirm Password" required />
        <Button text="PLAY NOW!" loading={loading} />
        <Link to="/">Already have an account? Sign In</Link>
      </FormContainer>
    </Container>
  );
};

export default SignUp;
