import { Container, Line, HorizontalDivisor } from "./styles";
import { KeyValueInfo } from "../../atoms";
import { IMatchLineProps } from "../../../libs/interfaces/molecules";

const MatchLine: React.FC<IMatchLineProps> = ({ isLast, lineData }) => {
  return (
    <Container>
      <Line>
        {lineData.map((info, index) => (
          <KeyValueInfo
            withDivisor={index !== lineData.length - 1}
            label={info.label}
            value={info.value}
          />
        ))}
      </Line>
      {isLast && <HorizontalDivisor />}
    </Container>
  );
};

export default MatchLine;
