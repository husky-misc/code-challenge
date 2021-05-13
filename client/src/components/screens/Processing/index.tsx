import React, { useEffect } from "react";
import { useLocation } from "react-router-dom";
import { useRanking } from "../../../hooks";

import { Container } from "./styles";

const Processing: React.FC = () => {
  const { processRanking, setLoading } = useRanking();
  const location = useLocation<{ logId: number }>();

  useEffect(() => {
    generateRanking();

    async function generateRanking() {
      const response = await processRanking({ logId: location.state.logId });

      setLoading(false);

      console.log(response);
    }
  }, []);

  return <Container>Processing</Container>;
};

export default Processing;
