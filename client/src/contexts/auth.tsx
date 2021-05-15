import React, { useCallback, useEffect, useState } from "react";
import { IAuthContextData, IUserData } from "../libs/interfaces/contexts";
import * as baseAPI from "../services/baseAPI";
import { authService } from "../services";
import { storageToken } from "../utils";

export const AuthContext = React.createContext<IAuthContextData>(
  {} as IAuthContextData
);

const AuthProvider: React.FC = ({ children }) => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const storagedToken = localStorage.getItem("@HuskyFire:token");
    const storagedUser = localStorage.getItem("@HuskyFire:user");

    storagedUser && storagedToken
      ? persistAuthenticate(storagedToken, JSON.parse(storagedUser))
      : setIsAuthenticated(false);

    setLoading(false);
  }, []);

  const createAuth = useCallback(async (credentials) => {
    setLoading(true);

    const response = await authService.createAuth(credentials);

    persistAuthenticate(response.data.token, response.data.user);

    return response;
  }, []);

  function persistAuthenticate(token: string, user: IUserData) {
    setIsAuthenticated(true);
    storageToken(token);
    storageUser(user);
    baseAPI.applyToken(token);
  }

  const logout = useCallback(async () => {
    localStorage.removeItem("@HuskyFire:user");
    localStorage.removeItem("@HuskyFire:token");
    localStorage.removeItem("@HuskyFire:ranking");
    setIsAuthenticated(false);
    baseAPI.unstickToken();
  }, []);

  const storageUser = useCallback((userData) => {
    localStorage.setItem("@HuskyFire:user", JSON.stringify(userData));
  }, []);

  return (
    <AuthContext.Provider
      value={{
        loading,
        setLoading,
        createAuth,
        isAuthenticated,
        logout,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export default AuthProvider;
