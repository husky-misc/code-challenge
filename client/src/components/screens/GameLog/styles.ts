import styled, { css } from "styled-components";
import { COLORS } from "../../../constants";

const headingCSS = css`
  font-size: 1.5rem;
  font-weight: 300;
  color: ${COLORS.light};
`;

export const Container = styled.main`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;

  padding: 3rem;
  height: 100vh;

  & > footer {
    display: flex;
    justify-content: center;
    align-items: baseline;
    gap: 0.8rem;

    width: 100%;

    & > h3 {
      ${headingCSS};
    }
  }
`;

export const Header = styled.header`
  display: flex;
  align-items: center;
  justify-content: space-between;

  width: 100%;

  & > div {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1.5rem;
    cursor: pointer;

    & > h2 {
      ${headingCSS};
    }
  }
`;

export const DownloadImage = styled.img`
  width: 34px;
`;

export const LogoutImage = styled.img`
  width: 46px;
`;

const labelCSS = css`
  display: block;
  margin-bottom: 0.5rem;
  color: ${COLORS.emphasizedGray};
  font-weight: 600;
  font-size: 0.9rem;
`;

export const UploadLog = styled.div<{ withLog: boolean }>`
  width: 100%;

  & > label:nth-of-type(1) {
    ${labelCSS};
  }

  & > label:nth-of-type(2) {
    display: flex;
    justify-content: center;
    align-items: center;

    min-height: 70px;
    padding: 1rem;
    background: ${COLORS.uploadBackground};
    border: 1px dashed ${COLORS.blueSky};
    border-radius: 20px;
    cursor: ${({ withLog }) => !withLog && "pointer"};

    & > p {
      font-size: 1.1rem;
      color: ${COLORS.text};
      margin-right: 0.8rem;
    }

    & > svg {
      cursor: pointer;
    }
  }

  & > input[type="file"] {
    visibility: hidden;
  }

  & > p {
    font-size: 0.9rem;
    margin-top: -0.8rem;
    color: ${COLORS.error};
  }
`;

export const TeamModeSwitch = styled.div<{ withTeamMode: boolean }>`
  display: flex;
  align-items: center;
  justify-content: space-between;

  width: 100%;
  margin: 0.4rem 0 1.2rem 0;

  & > label {
    ${labelCSS};
  }

  & > button {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 60px;
    height: 22px;
    padding: 4px;
    border-radius: 1rem;
    cursor: pointer;
    transition: all 0.3s ease-in;

    background: ${({ withTeamMode }) =>
      withTeamMode ? COLORS.success : COLORS.white};
    border: 1px solid
      ${({ withTeamMode }) =>
        withTeamMode ? COLORS.success : COLORS.inputBorder};

    & > div {
      width: 28px;
      height: 12px;
      border-radius: 1rem;
      transition: all 0.3s ease-in;

      background: ${({ withTeamMode }) =>
        withTeamMode ? COLORS.white : COLORS.emphasizedGray};
    }
  }
`;
