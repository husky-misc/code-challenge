import styled from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.main`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;

  padding: 5rem;

  & > header {
    display: flex;
    justify-content: center;
    align-items: center;

    & > h1 {
      font-size: 4rem;
      font-weight: 500;
      margin-top: 2rem;
      margin-right: 2rem;
      color: ${COLORS.light};
    }
  }

  & > h2 {
    font-size: 1.8rem;
    font-weight: 600;
    margin-top: 2rem;
    color: ${COLORS.light};
  }
`;
