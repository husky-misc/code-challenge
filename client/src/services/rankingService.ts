import * as baseAPI from "./baseAPI";
import { URLS } from "../constants";
import { ICreateLog, IProcessRanking } from "../libs/interfaces/screens";
import { IResponse } from "../libs/interfaces/services";

async function createLog(data: ICreateLog): Promise<IResponse> {
  const response = await baseAPI.serviceHandler(async () => {
    const formData = new FormData();

    data.description && formData.append("description", data.description);
    formData.append("file", data.log);
    formData.append("team_mode", String(data.teamMode));
    formData.append("game_mode", "contra_squad");

    console.log(baseAPI.client.defaults);

    const serviceResponse = await baseAPI.client.post(URLS.LOGS, formData);

    return serviceResponse;
  });

  return response;
}

async function downloadMatchExample(teamMode: boolean): Promise<IResponse> {
  const response = await baseAPI.serviceHandler(async () => {
    let type = "match";
    if (teamMode) type = "team";

    const serviceResponse = await baseAPI.client.get(URLS.DOWNLOAD_LOG(type));

    return serviceResponse;
  });

  return response;
}

async function processRanking(data: IProcessRanking): Promise<IResponse> {
  const response = await baseAPI.serviceHandler(async () => {
    const serviceResponse = await baseAPI.client.post(URLS.RANKINGS, {
      log_id: data.logId,
    });

    return serviceResponse;
  });

  return response;
}

export default {
  createLog,
  downloadMatchExample,
  processRanking,
};
