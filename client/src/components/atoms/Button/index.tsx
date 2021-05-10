import { Container } from "./styles";
import { IButtonProps } from "../../../libs/interfaces/atoms";

const Button: React.FC<IButtonProps> = ({ text, clickFunction }) => {
  return <Container onClick={clickFunction}>{text}</Container>;
};

export default Button;
