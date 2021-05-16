import * as baseAPI from "./baseAPI";
import { URLS } from "../constants";
import { IResponse } from "../libs/interfaces/services";
import { ICredentials } from "../libs/interfaces/contexts";

async function createUser(data: ICredentials): Promise<IResponse> {
  const response = await baseAPI.serviceHandler(async () => {
    const serviceResponse = await baseAPI.client.post(URLS.USERS, data);

    return serviceResponse;
  });

  return response;
}

export default {
  createUser,
};
