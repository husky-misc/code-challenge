import { Container } from "./styles";
import { KeyValueInfo } from "../../atoms";
import React from "react";
import { IMatchHeaderProps } from "../../../libs/interfaces/organisms";

const MatchHeader: React.FC<IMatchHeaderProps> = ({
  decorationImage,
  headerData,
}) => {
  return (
    <Container>
      {headerData.map((line, index) => (
        <KeyValueInfo
          withDivisor={index !== headerData.length - 1}
          label={line.label}
          value={line.value}
        />
      ))}
      {decorationImage && <img src={decorationImage} alt="Winner Player" />}
    </Container>
  );
};

export default MatchHeader;
