import styled, { css } from "styled-components";
import { COLORS } from "../../../constants";

export const Container = styled.button<{ isLoading: boolean | undefined }>`
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

  & > span {
    margin-left: ${({ isLoading }) => isLoading && "1rem"};
  }

  ${({ isLoading }) =>
    isLoading &&
    css`
      filter: opacity(0.6);
      cursor: not-allowed;
    `};

  &:hover {
    background: ${COLORS.darkPrimary};
  }
`;
