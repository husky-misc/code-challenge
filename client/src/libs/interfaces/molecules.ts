import { FormHandles } from "@unform/core";
import { RefObject } from "react";

export interface FormContainerProps {
  formRef: RefObject<FormHandles>;
  handleSubmit(data: any): Promise<void>;
}
