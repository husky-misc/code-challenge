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

  useEffect(() => {
    const storagedRanking = localStorage.getItem("@HuskyFire:ranking");

    storagedRanking && setRanking(JSON.parse(storagedRanking));
  }, []);

  const createLog = useCallback(async (logData) => {
    setLoading(true);

    const response = await rankingService.createLog(logData);

    if (response.success) setLogId(response.data.id);

    return response;
  }, []);

  const processRanking = useCallback(async (rankingData) => {
    setLoading(true);

    const response = await rankingService.processRanking(rankingData);

    if (response.success) storageRanking(response.data);

    return response;
  }, []);

  const storageRanking = useCallback((rankingData) => {
    setRanking(rankingData);
    localStorage.setItem("@HuskyFire:ranking", JSON.stringify(rankingData));
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
