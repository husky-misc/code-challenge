export interface ISignIn {
  email: string;
  password: string;
}

export interface ISignUp {
  email: string;
  password: string;
  confirmPassword: string;
}

export interface IProcessRanking {
  description: string;
  teamMode: boolean;
}
