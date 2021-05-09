import React from "react";

export interface AuthContextData {
  loading: boolean;
  isAuthenticated: boolean;
}

export const AuthContext = React.createContext<AuthContextData>(
  {} as AuthContextData
);

const AuthProvider: React.FC = ({ children }) => {
  const [isAuthenticated, setIsAuthenticated] = React.useState(false);
  const [loading, setLoading] = React.useState(true);

  React.useEffect(() => {
    setLoading(false);
    setIsAuthenticated(true);
  }, []);

  return (
    <AuthContext.Provider
      value={{
        loading,
        isAuthenticated,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export default AuthProvider;
