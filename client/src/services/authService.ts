import * as baseAPI from "./baseAPI";
import { URLS } from "../constants";
import { ICredentials } from "../libs/interfaces/contexts";
import { IResponse } from "../libs/interfaces/services";

async function createAuth(data: ICredentials): Promise<IResponse> {
  const response = await baseAPI.serviceHandler(async () => {
    const serviceResponse = await baseAPI.client.post(URLS.AUTH, data);

    return serviceResponse;
  });

  return response;
}

export default {
  createAuth,
};
