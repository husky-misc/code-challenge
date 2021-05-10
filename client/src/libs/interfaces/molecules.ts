import { FormHandles } from "@unform/core";
import { RefObject } from "react";
import { ISignIn } from "./screens";

export interface FormContainerProps {
  formRef: RefObject<FormHandles>;
  handleSubmit(data: ISignIn): Promise<void>;
}
