import { InputHTMLAttributes } from "react";

export interface IInputProps extends InputHTMLAttributes<HTMLInputElement> {
  name: string;
  label?: string;
  error?: string;
  required?: boolean;
}

export interface IButtonProps {
  text: string;
  clickFunction?(): void;
}
