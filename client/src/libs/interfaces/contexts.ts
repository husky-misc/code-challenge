import { ICreateLog, IProcessRanking } from "./screens";
import { IResponse } from "./services";

export interface IAuthContextData {
  loading: boolean;
  isAuthenticated: boolean;
  setLoading(state: boolean): void;
  createAuth(credentials: ICredentials): Promise<IResponse>;
  logout(): void;
}

export interface IRankingContextData {
  ranking: any;
  loading: boolean;
  logId: string | number | null;
  setLoading(state: boolean): void;
  createLog(logData: ICreateLog): Promise<IResponse>;
  processRanking(rankingData: IProcessRanking): Promise<IResponse>;
}

export interface IUserData {
  id: string | number;
  email: string;
}

export interface ICredentials {
  email: string;
  password: string;
}

export interface IUserContextData {
  user: IUserData;
  loading: boolean;
  setLoading(state: boolean): void;
  createUser(userData: ICredentials): Promise<IResponse>;
}
