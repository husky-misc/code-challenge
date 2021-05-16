import { Link } from "react-router-dom";
import { Container, EyeImage } from "./styles";
import { IMAGES } from "../../../constants";
import { FlexOffset } from "../../atoms";

const GlobalRankingLink: React.FC = () => {
  return (
    <Container>
      <FlexOffset />
      <h3>GLOBAL RANKING</h3>
      <Link to="/global">
        <EyeImage src={IMAGES.eye} alt="Ver Ranking Global" />
      </Link>
    </Container>
  );
};

export default GlobalRankingLink;
