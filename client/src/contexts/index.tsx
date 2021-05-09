import React from "react";
import AuthProvider from "./auth";
import RankingProvider from "./ranking";

const AppProvider: React.FC = ({ children }) => (
  <AuthProvider>
    <RankingProvider>{children}</RankingProvider>
  </AuthProvider>
);

export default AppProvider;
