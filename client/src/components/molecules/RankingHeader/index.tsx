import { Container, LogoutImage } from "./styles";
import { IMAGES } from "../../../constants";
import { FlexOffset } from "../../atoms";
import { useAuth } from "../../../hooks";
import { useCallback } from "react";
import { useHistory } from "react-router-dom";

const Button: React.FC = () => {
  const { logout } = useAuth();
  const history = useHistory();

  const handleLogout = useCallback(() => {
    logout();
    history.push("/");
  }, []);

  return (
    <Container>
      <FlexOffset />
      <LogoutImage
        src={IMAGES.logout}
        alt="Sair do Husky Fire"
        onClick={handleLogout}
      />
    </Container>
  );
};

export default Button;
