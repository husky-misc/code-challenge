import styled from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.section`
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  width: 100%;
`;

export const Body = styled.section`
  margin: 1rem 0;
  padding: 0.6rem;
  background: ${COLORS.white};
  box-shadow: 0px 4px 20px rgba(204, 204, 204, 0.25);
  border-radius: 10px;

  @media (max-width: 820px) {
    flex-direction: column;
  }
`;
