import styled from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.footer`
  display: flex;
  justify-content: center;
  align-items: baseline;
  gap: 0.8rem;

  width: 100%;

  & > h3 {
    font-size: 1.7rem;
    font-weight: 300;
    color: ${COLORS.light};
  }
`;

export const EyeImage = styled.img`
  width: 60px;
`;
