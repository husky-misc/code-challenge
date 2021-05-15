import React from "react";
import AuthProvider from "./auth";
import RankingProvider from "./ranking";
import UserProvider from "./user";

const AppProvider: React.FC = ({ children }) => (
  <AuthProvider>
    <UserProvider>
      <RankingProvider>{children}</RankingProvider>
    </UserProvider>
  </AuthProvider>
);

export default AppProvider;
