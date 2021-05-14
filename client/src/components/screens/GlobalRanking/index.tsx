import React, { useEffect } from "react";
import { useHistory } from "react-router";
import { useRanking } from "../../../hooks";
import { IMatch } from "../../../libs/interfaces/organisms";
import { fixtureGlobalRankingData } from "../../../utils/fixtures/globalRankingData";
import { Logo, GlobalRankingLink } from "../../atoms";
import { RankingHeader } from "../../molecules";
import { Match } from "../../organisms";
import { Container, RankingTable } from "./styles";

const GlobalRanking: React.FC = () => {
  const { ranking } = useRanking();
  const history = useHistory();

  useEffect(() => {
    console.log(ranking);
    !ranking && history.push("/");
  }, [ranking]);

  return (
    <Container>
      <RankingHeader />

      <RankingTable>
        <section>
          <Logo size={50} />

          <h1>GLOBAL RANKING</h1>
        </section>

        {fixtureGlobalRankingData.map((match: IMatch) => (
          <Match key={match.id} match={match} />
        ))}
      </RankingTable>

      <GlobalRankingLink />
    </Container>
  );
};

export default GlobalRanking;
