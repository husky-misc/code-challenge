import { ICreateLog, IProcessRanking } from "./screens";
import { IResponse } from "./services";

export interface IRankingContextData {
  loading: boolean;
  logId: string | number | null;
  createLog(logData: ICreateLog): Promise<IResponse>;
  processRanking(rankingData: IProcessRanking): Promise<IResponse>;
  setLoading(state: boolean): void;
  ranking: any;
}
