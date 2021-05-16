export interface IMatchProps {
  match: IMatch;
}

export interface IMatch {
  id: string | number;
  started_at: string;
  ended_at: string;
  frags: number;
  strike_player: any;
  winner: any;
  players: IPlayer[];
}

export interface IPlayer {
  id: string | number;
  name: string;
  frags: number;
  deads: number;
  awarded: boolean;
  strong_weapon: string;
  strong_killer: boolean;
  score: number;
}

export interface IMatchHeaderProps {
  decorationImage: string;
  headerData: Array<{ label: string; value: string | number | boolean }>;
}
