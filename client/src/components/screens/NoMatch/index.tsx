import { Container, WhiteBlock } from "./styles";
import { COLORS, ICONS } from "../../../constants";

const Splash: React.FC = () => {
  return (
    <Container>
      <WhiteBlock>
        {<ICONS.AI.AiOutlineClose size={140} color={COLORS.error} />}
        <h1>No Route Match!</h1>
        <p>You are trying to access a route that does not exist...</p>
      </WhiteBlock>
    </Container>
  );
};

export default Splash;
