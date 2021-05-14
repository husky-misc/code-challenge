import React, { useEffect } from "react";
import { useHistory } from "react-router-dom";
import { ClipLoader } from "react-spinners";
import { COLORS } from "../../../constants";
import { useRanking } from "../../../hooks";

import { Container } from "./styles";

const Processing: React.FC = () => {
  const { processRanking, setLoading, ranking, logId } = useRanking();
  const history = useHistory();

  useEffect(() => {
    generateRanking();

    async function generateRanking() {
      if (!logId) return history.push("/");

      const { success } = await processRanking({ logId });

      success && ranking && history.push("/ranking");

      setLoading(false);
    }
  }, []);

  return (
    <Container>
      <header>
        <h1>PROCESSING...</h1>
        <ClipLoader color={COLORS.white} size={50} />
      </header>

      <h2>
        Wait a few seconds and then you will be redirected to the Ranking!
      </h2>
    </Container>
  );
};

export default Processing;
