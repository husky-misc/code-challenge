import { useContext } from "react";
import { RankingContext, RankingContextData } from "../contexts/ranking";

export default function useRanking(): RankingContextData {
  const context = useContext(RankingContext);

  if (!context) {
    throw new Error("useUser must be used within an PerfilProvider");
  }

  return context;
}
