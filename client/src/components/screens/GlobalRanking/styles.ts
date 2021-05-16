import styled from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.main`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;

  padding: 2rem;
  height: 100vh;
`;

export const RankingTable = styled.article`
  display: flex;
  align-items: center;
  flex-direction: column;

  overflow-y: scroll;
  max-width: 1360px;
  max-height: calc(80vh - 4rem);
  border-radius: 1.5rem;
  background: ${COLORS.white};
  margin: 8px;
  padding: 1rem 2rem 2rem 2rem;

  & > section {
    display: flex;
    align-items: center;
    justify-content: space-between;

    & > h1 {
      display: block;
      font-size: 1.7rem;
      color: ${COLORS.shadowText};
      font-weight: 300;
      margin-top: 1rem;
    }

    @media (max-width: 980px) {
      & > h1 {
        font-size: 1.4rem;
      }
    }

    @media (max-width: 820px) {
      & > h1 {
        font-size: 1.4rem;
        margin-bottom: 2rem;
      }

      & > div {
        display: none;
      }
    }
  }

  & > p {
    font-size: 1rem;
    color: ${COLORS.text};
    font-weight: 400;
    margin: 1rem 0 2rem 0;
  }
`;
