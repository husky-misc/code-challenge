import styled from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.main`
  display: flex;
  justify-content: center;
  align-items: center;

  height: 100vh;
`;

export const WhiteBlock = styled.section`
  display: flex;
  flex: 1;
  justify-content: baseline;
  align-items: center;
  flex-direction: column;

  max-width: 580px;
  border-radius: 1.5rem;
  background: ${COLORS.white};
  margin: 8px;
  padding: 4rem;

  & > h1 {
    font-size: 2.3rem;
    color: ${COLORS.text};
    font-weight: 400;
  }

  & > p {
    font-size: 1rem;
    color: ${COLORS.text};
    font-weight: 400;
    margin: 1rem 0 2rem 0;
  }
`;

export const CompleteImage = styled.img`
  max-width: 5rem;
  margin-bottom: 1.8rem;
`;
