import Logo from "../../atoms/Logo";
import { Container, FormChildren } from "./styles";
import { FormContainerProps } from "../../../libs/interfaces/molecules";

const FormContainer: React.FC<FormContainerProps> = ({
  formRef,
  handleSubmit,
  children,
}) => {
  return (
    <Container>
      <Logo />
      <FormChildren ref={formRef} onSubmit={handleSubmit}>
        {children}
      </FormChildren>
    </Container>
  );
};

export default FormContainer;
