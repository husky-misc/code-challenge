import { Container, Info, Divisor } from "./styles";

interface IKeyValueInfoProps {
  label: string;
  withDivisor?: boolean;
  value: string | number | boolean;
}

const KeyValueInfo: React.FC<IKeyValueInfoProps> = ({
  label,
  withDivisor,
  value,
}) => {
  return (
    <Container>
      <Info>
        <label>{label}</label>
        <span>{value}</span>
      </Info>

      {withDivisor && <Divisor />}
    </Container>
  );
};

export default KeyValueInfo;
