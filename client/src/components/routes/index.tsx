import React from "react";
import AuthRoutes from "./auth";
import AppRoutes from "./app";
import Splash from "../screens/Splash";
import { useAuth } from "../../hooks";

const Routes: React.FC = () => {
  const { isAuthenticated, loading } = useAuth();

  if (loading) {
    return <Splash />;
  }

  return false ? <AppRoutes /> : <AuthRoutes />;
};

export default Routes;
