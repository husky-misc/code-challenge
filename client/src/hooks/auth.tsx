import { useContext } from "react";
import { AuthContext } from "../contexts/auth";
import { IAuthContextData } from "../libs/interfaces/contexts";

export default function useAuth(): IAuthContextData {
  const context = useContext(AuthContext);

  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }

  return context;
}
