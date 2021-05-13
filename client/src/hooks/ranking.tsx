import { useContext } from "react";
import { RankingContext } from "../contexts/ranking";
import { IRankingContextData } from "../libs/interfaces/contexts";

export default function useRanking(): IRankingContextData {
  const context = useContext(RankingContext);

  if (!context) {
    throw new Error("useUser must be used within an PerfilProvider");
  }

  return context;
}
