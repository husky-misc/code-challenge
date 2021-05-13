import React, { useCallback, useEffect, useState } from "react";
import { IRankingContextData } from "../libs/interfaces/contexts";
import { rankingService } from "../services";

export const RankingContext = React.createContext<IRankingContextData>(
  {} as IRankingContextData
);

const RankingProvider: React.FC = ({ children }) => {
  const [loading, setLoading] = useState(false);
  const [logId, setLogId] = useState(null);
  const [ranking, setRanking] = useState(null);

  const createLog = useCallback(async (logData) => {
    setLoading(true);

    const response = await rankingService.createLog(logData);

    if (response.success) setLogId(response.data.id);

    return response;
  }, []);

  const processRanking = useCallback(async (rankingData) => {
    setLoading(true);

    const response = await rankingService.processRanking(rankingData);

    if (response.success) setRanking(response.data);

    return response;
  }, []);

  return (
    <RankingContext.Provider
      value={{
        loading,
        logId,
        createLog,
        processRanking,
        setLoading,
        ranking,
      }}
    >
      {children}
    </RankingContext.Provider>
  );
};

export default RankingProvider;
