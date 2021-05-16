import { IMAGES } from "../../../constants";
import { Container } from "./styles";
import { LogoProps } from "../../../libs/types/atoms";

const Logo: React.FC<LogoProps> = ({ size }) => {
  return (
    <Container size={size}>
      <img src={IMAGES.logo} alt="Husky Fire Logo" />
    </Container>
  );
};

export default Logo;
