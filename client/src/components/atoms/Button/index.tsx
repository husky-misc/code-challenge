import ClipLoader from "react-spinners/ClipLoader";
import { Container } from "./styles";
import { IButtonProps } from "../../../libs/interfaces/atoms";
import { COLORS, ICONS } from "../../../constants";

const Button: React.FC<IButtonProps> = ({ text, clickFunction, loading }) => {
  return (
    <Container onClick={clickFunction} isLoading={loading}>
      <span>{text}</span>
      {loading && <ClipLoader color={COLORS.white} size={20} />}
    </Container>
  );
};

export default Button;
