export interface ISignIn {
  email: string;
  password: string;
}

export interface ISignUp {
  email: string;
  password: string;
  confirmPassword: string;
}

export interface ICreateLog {
  description: string;
  teamMode: boolean;
  log: File;
}

export interface IProcessRanking {
  logId: number | string;
}
