import styled from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.button`
  display: flex;
  justify-content: center;
  align-items: center;

  width: 100%;
  height: 3.3rem;
  margin-top: 1rem;
  padding: 6px 1.5rem;
  font-weight: 900;
  background: ${COLORS.primary};
  color: ${COLORS.white};
  border-radius: 1rem;
  border: 0;
  transition: background 0.2s linear;

  &:hover {
    background: ${COLORS.darkPrimary};
  }
`;
