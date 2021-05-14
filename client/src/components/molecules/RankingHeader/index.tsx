import { Container, LogoutImage } from "./styles";
import { IMAGES } from "../../../constants";
import { FlexOffset } from "../../atoms";

const Button: React.FC = () => {
  return (
    <Container>
      <FlexOffset />
      <LogoutImage src={IMAGES.logout} alt="Sair do Husky Fire" />
    </Container>
  );
};

export default Button;
