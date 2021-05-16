import styled from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
`;

export const Info = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  gap: 0.62rem;

  & > label {
    font-size: 0.8rem;
    font-weight: 300;
    color: ${COLORS.shadowText};
  }

  & > span {
    display: block;
    font-size: 0.8rem;
    font-weight: 400;
    color: ${COLORS.text};
  }

  @media (max-width: 980px) {
    gap: 0.4rem;

    & > label {
      font-size: 0.7rem;
    }

    & > span {
      font-size: 0.7rem;
    }
  }

  @media (max-width: 820px) {
    gap: 1rem;

    & > label {
      font-size: 1rem;
    }

    & > span {
      font-size: 1rem;
    }
  }
`;

export const Divisor = styled.div`
  width: 0.7px;
  height: 20px;
  margin: 8px;
  background: ${COLORS.light};

  @media (max-width: 820px) {
    height: 0;
  }
`;
