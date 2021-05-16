import ClipLoader from "react-spinners/ClipLoader";
import { Container } from "./styles";
import { COLORS } from "../../../constants";

const Splash: React.FC = () => {
  return (
    <Container>
      <ClipLoader color={COLORS.white} size={120} />
    </Container>
  );
};

export default Splash;
