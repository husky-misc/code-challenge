import styled from "styled-components";
import { COLORS } from "../../../constants";

interface InputStyleProps {
  withError: boolean;
  isFocused: boolean;
  isFilled: boolean;
}

export const Container = styled.div<InputStyleProps>`
  width: inherit;
  margin-bottom: 1.5rem;

  & > label {
    color: ${COLORS.emphasizedGray};
    font-weight: 600;
    font-size: 0.9rem;
  }

  & > input {
    width: inherit;
    height: 3.3rem;
    padding: 0.5rem;
    margin-top: 0.6rem;
    border-radius: 1.2rem;
    border: 0.12rem solid ${COLORS.inputBorder};
    background: ${COLORS.input};
    color: ${COLORS.emphasizedGray};
    color: ${({ isFocused, isFilled }) =>
      (isFocused || isFilled) && COLORS.primary};
    border-color: ${({ withError }) => withError && COLORS.error};
    border-color: ${({ isFocused }) => isFocused && COLORS.primary};
  }

  & > p {
    width: inherit;
    font-size: 0.9rem;
    color: ${COLORS.error};
    margin-top: 0.6rem;
    margin-bottom: 0.2rem;
  }
`;
