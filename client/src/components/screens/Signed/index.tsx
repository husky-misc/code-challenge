import { useHistory } from "react-router-dom";
import { Button } from "../../atoms";
import { Container, WhiteBlock, CompleteImage } from "./styles";
import { IMAGES } from "../../../constants";

const Signed: React.FC = () => {
  const history = useHistory();

  return (
    <Container>
      <WhiteBlock>
        <CompleteImage src={IMAGES.complete} />
        <h1>Registration Complete!</h1>
        <p>You are now part of the Husky Gaming Platform!</p>
        <Button text="Sign In" clickFunction={() => history.push("/")} />
      </WhiteBlock>
    </Container>
  );
};

export default Signed;
