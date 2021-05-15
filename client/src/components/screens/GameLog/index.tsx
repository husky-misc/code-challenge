import React, { ChangeEvent, useCallback, useRef, useState } from "react";
import { FormHandles } from "@unform/core";
import * as Yup from "yup";
import { useHistory } from "react-router-dom";
import Swal from "sweetalert2";
import fileDownload from "js-file-download";
import { IMAGES, ICONS, COLORS } from "../../../constants";
import { FlexOffset, GlobalRankingLink } from "../../atoms";
import { FormContainer } from "../../molecules";
import { ICreateLog } from "../../../libs/interfaces/screens";
import {
  Container,
  Header,
  DownloadImage,
  LogoutImage,
  UploadLog,
  TeamModeSwitch,
} from "./styles";
import { rankingService } from "../../../services";
import { gameLog } from "../../../libs/validations";
import { getValidationErrors, truncateString } from "../../../utils";
import { Button, Input } from "../../atoms";
import { useRanking } from "../../../hooks";

const GameLog: React.FC = () => {
  const formRef = useRef<FormHandles>(null);
  const uploadLogRef = useRef<HTMLInputElement>(null);

  const history = useHistory();
  const { loading, setLoading, createLog } = useRanking();

  const [log, setLog] = useState<File | null>(null);
  const [logError, setLogError] = useState<string | null>(null);
  const [teamMode, setTeamMode] = useState(false);

  const handleSubmit = useCallback(
    async (data: ICreateLog): Promise<void> => {
      try {
        if (!log) {
          Swal.fire(
            "Impossible...",
            "To process a Ranking, a Game Log is required!",
            "error"
          );
          return;
        }

        formRef.current?.setErrors({});
        setLogError(null);

        const gamelogData = { ...data, log, teamMode };

        await gameLog.validate(gamelogData, {
          abortEarly: false,
        });

        const response = await createLog({
          description: gamelogData.description,
          log: gamelogData.log,
          teamMode: gamelogData.teamMode,
        });

        response.success && response.data.id && history.push("/processing");
      } catch (error) {
        if (error instanceof Yup.ValidationError) {
          const errors = getValidationErrors(error);
          formRef.current?.setErrors(errors);
          setLogError(errors.log);

          return;
        } else {
          Swal.fire("Error...", "Something went wrong!", "error");
        }
      } finally {
        setLoading(false);
      }
    },
    [log]
  );

  const downloadMatchExample = useCallback(async () => {
    const response = await rankingService.downloadMatchExample(teamMode);

    if (!response.success) return;
    console.log(response);
    fileDownload(response.data, "example.txt");
  }, []);

  function handleSelectLog(event: ChangeEvent<HTMLInputElement>) {
    if (!event.target.files) {
      return;
    }

    const selectedFile = event.target.files[0];

    setLog(selectedFile);
  }

  function handleClearLog(event: any) {
    event.preventDefault();

    setLog(null);
    setLogError(null);

    if (uploadLogRef.current) {
      uploadLogRef.current.value = "";
    }
  }

  return (
    <Container>
      <Header>
        <div onClick={downloadMatchExample}>
          <DownloadImage src={IMAGES.download} alt="Baixar Exemplo de Log" />
          <h2>{teamMode ? "TEAM GAME LOG EXAMPLE" : "GAME LOG EXAMPLE"}</h2>
        </div>
        <LogoutImage src={IMAGES.logout} alt="Sair do Husky Fire" />
      </Header>

      <section>
        <FormContainer formRef={formRef} handleSubmit={handleSubmit}>
          <Input name="description" label="Descrição" />

          <UploadLog withLog={!!log}>
            <label>Add Game Logs *</label>
            <label htmlFor={!log ? "log" : ""}>
              {log ? (
                <>
                  <p>{truncateString(log.name, 30)}</p>
                  <ICONS.AI.AiOutlineClose
                    size={20}
                    color={COLORS.error}
                    onClick={(event) => handleClearLog(event)}
                  />
                </>
              ) : (
                <ICONS.FI.FiPlus size={24} color={COLORS.lightBlue} />
              )}
            </label>

            <input
              id="log"
              type="file"
              ref={uploadLogRef}
              onChange={handleSelectLog}
            />

            {logError && <p>{logError}</p>}
          </UploadLog>

          <TeamModeSwitch withTeamMode={!!teamMode}>
            <label>TEAM mode?</label>
            <button type="button" onClick={() => setTeamMode(!teamMode)}>
              {!!teamMode && <FlexOffset />}
              <div />
            </button>
          </TeamModeSwitch>

          <Button text="PROCESS RANKING" loading={loading} />
        </FormContainer>
      </section>

      <GlobalRankingLink />
    </Container>
  );
};

export default GameLog;
