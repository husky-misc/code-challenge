import React, { useEffect } from "react";

export interface RankingContextData {
  loading: boolean;
}

export const RankingContext = React.createContext<RankingContextData>(
  {} as RankingContextData
);

const RankingProvider: React.FC = ({ children }) => {
  const [loading, setLoading] = React.useState(true);

  useEffect(() => {
    setLoading(false);
  }, []);

  return (
    <RankingContext.Provider
      value={{
        loading,
      }}
    >
      {children}
    </RankingContext.Provider>
  );
};

export default RankingProvider;
