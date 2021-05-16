import { Container, Body } from "./styles";
import { MatchHeader, MatchLine } from "../../molecules";
import { IMAGES } from "../../../constants";
import { IMatchProps } from "../../../libs/interfaces/organisms";

const Match: React.FC<IMatchProps> = ({ match }) => {
  return (
    <Container>
      <MatchHeader
        decorationImage={IMAGES.winner}
        headerData={[
          { label: "ID", value: match.id },
          { label: "MATCH STARTED AT", value: match.started_at },
          { label: "MATCH ENDED AT", value: match.ended_at },
          { label: "FRAGS", value: match.frags },
          { label: "STRIKE PLAYER", value: match.strike_player.name },
          { label: "WINNER PLAYER", value: match.winner.name },
        ]}
      />

      <Body>
        {match.players.map((player, index) => (
          <MatchLine
            key={player.id}
            isLast={index !== match.players.length - 1}
            lineData={[
              { label: "PLAYER ID", value: player.id },
              { label: "NAME", value: player.name },
              { label: "FRAGS", value: player.frags },
              { label: "DEADS", value: player.deads },
              { label: "AWARDED", value: player.awarded },
              { label: "STRONG WEAPON", value: player.strong_weapon },
              { label: "STRONG KILLER", value: player.strong_killer },
              { label: "SCORE", value: player.score },
            ]}
          />
        ))}
      </Body>
    </Container>
  );
};

export default Match;
