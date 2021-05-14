import React, { useEffect } from "react";
import { useHistory } from "react-router";
import { useRanking } from "../../../hooks";
import { IMatch } from "../../../libs/interfaces/organisms";
import { truncateString } from "../../../utils";
import { fixtureRankingData } from "../../../utils/fixtures/rankingData";
import { Logo, GlobalRankingLink } from "../../atoms";
import { RankingHeader } from "../../molecules";
import { Match } from "../../organisms";
import { Container, RankingTable } from "./styles";

const Ranking: React.FC = () => {
  const { ranking } = useRanking();
  const history = useHistory();

  useEffect(() => {
    !ranking && history.push("/");
  }, [ranking]);

  return (
    <Container>
      <RankingHeader />

      <RankingTable>
        <section>
          <Logo size={50} />

          <h1>
            RANKING ID: {ranking[0] && truncateString(ranking[0].match_id, 10)}{" "}
          </h1>
        </section>

        {fixtureRankingData.map((match: IMatch) => (
          <Match key={match.id} match={match} />
        ))}
      </RankingTable>

      <GlobalRankingLink />
    </Container>
  );
};

export default Ranking;
