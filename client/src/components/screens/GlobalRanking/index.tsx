import React, { useEffect } from "react";
import { useHistory } from "react-router";
import { ClipLoader } from "react-spinners";
import { COLORS } from "../../../constants";
import { useRanking } from "../../../hooks";
import { IMatch } from "../../../libs/interfaces/organisms";
import { Logo, GlobalRankingLink } from "../../atoms";
import { RankingHeader } from "../../molecules";
import { Match } from "../../organisms";
import { Container, RankingTable } from "./styles";

const GlobalRanking: React.FC = () => {
  const {
    loading,
    setLoading,
    globalRanking,
    processGlobalRanking,
  } = useRanking();
  const history = useHistory();

  useEffect(() => {
    loadGlobalRanking();

    async function loadGlobalRanking() {
      const { data } = await processGlobalRanking();

      console.log(data);

      setLoading(false);

      !data && history.push("/");
    }
  }, []);

  if (loading || !globalRanking) {
    return (
      <Container>
        <ClipLoader color={COLORS.white} size={120} />
      </Container>
    );
  }

  return (
    <Container>
      <RankingHeader />

      <RankingTable>
        <section>
          <Logo size={50} />

          <h1>GLOBAL RANKING</h1>
        </section>

        {globalRanking.map((match: IMatch) => (
          <Match key={match.id} match={match} />
        ))}
      </RankingTable>

      <GlobalRankingLink />
    </Container>
  );
};

export default GlobalRanking;
