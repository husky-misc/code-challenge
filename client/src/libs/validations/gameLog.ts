import * as Yup from "yup";

export const gameLog = Yup.object().shape({
  description: Yup.string().max(200),
  log: Yup.mixed()
    .test(
      "fileSize",
      "File too large",
      (value) => value && value.size <= 10 * 1024
    )
    .test(
      "fileFormat",
      "Only .txt files allowed.",
      (value) => value.type === "text/plain"
    ),
});

export default gameLog;
