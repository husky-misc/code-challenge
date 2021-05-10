import styled from "styled-components";

import { LogoProps } from "../../../libs/types/atoms";

export const Container = styled.div<LogoProps>`
  display: flex;
  justify-content: center;
  align-items: center;

  & > img {
    max-width: ${({ size }) => (size ? `${size}%` : "100%")};
  }

  @media (max-width: 580px) {
    & > img {
      margin-top: 1.8rem;
    }
  }
`;
