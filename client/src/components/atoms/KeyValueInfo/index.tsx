import { COLORS, ICONS } from "../../../constants";
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
        {typeof value === "boolean" ? (
          <span>
            {value ? (
              <ICONS.AI.AiOutlineCheck size={20} color={COLORS.success} />
            ) : (
              <ICONS.AI.AiOutlineClose size={20} color={COLORS.error} />
            )}
          </span>
        ) : (
          <span>{value}</span>
        )}
      </Info>

      {withDivisor && <Divisor />}
    </Container>
  );
};

export default KeyValueInfo;
