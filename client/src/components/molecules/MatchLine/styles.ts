import styled from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.section``;

export const Line = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;

  @media (max-width: 820px) {
    flex-direction: column;
  }
`;

export const HorizontalDivisor = styled.div`
  height: 0.7px;
  width: 94%;
  margin: 10px auto;
  background: ${COLORS.light};
`;
