import styled from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.header`
  display: flex;
  justify-content: center;
  align-items: center;

  width: 100%;
  margin: 1rem 0;
  padding: 0.6rem;
  background: ${COLORS.white};
  box-shadow: 0px 4px 20px rgba(204, 204, 204, 0.25);
  border-radius: 10px;

  & img {
    display: block;
    margin-left: 0.4rem;
  }

  @media (max-width: 820px) {
    flex-direction: column;

    & img {
      margin-top: 0.7rem;
      margin-left: 0.7rem;
    }
  }
`;
