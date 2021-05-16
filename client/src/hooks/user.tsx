import { useContext } from "react";
import { UserContext } from "../contexts/user";
import { IUserContextData } from "../libs/interfaces/contexts";

export default function useUser(): IUserContextData {
  const context = useContext(UserContext);

  if (!context) {
    throw new Error("useUser must be used within an UserProvider");
  }

  return context;
}
