import React, { useCallback, useState } from "react";
import { IUserContextData, IUserData } from "../libs/interfaces/contexts";
import * as baseAPI from "../services/baseAPI";
import { userService } from "../services";
import { storageToken } from "../utils";

export const UserContext = React.createContext<IUserContextData>(
  {} as IUserContextData
);

const UserProvider: React.FC = ({ children }) => {
  const [loading, setLoading] = useState(false);
  const [user, setUser] = useState({} as IUserData);

  const createUser = useCallback(async (userData) => {
    setLoading(true);

    const response = await userService.createUser(userData);

    if (response.success && response.data.token) {
      persistAuthenticate(response.data.token, response.data.user);
    }

    return response;
  }, []);

  function persistAuthenticate(token: string, user: IUserData) {
    storageUser(user);
    storageToken(token);
    baseAPI.applyToken(token);
  }

  const storageUser = useCallback((userData) => {
    setUser(userData);
    localStorage.setItem("@HuskyFire:user", JSON.stringify(userData));
  }, []);

  return (
    <UserContext.Provider
      value={{
        loading,
        createUser,
        setLoading,
        user,
      }}
    >
      {children}
    </UserContext.Provider>
  );
};

export default UserProvider;
