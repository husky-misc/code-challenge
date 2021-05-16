const LOGS = "api/v1/logs";
const AUTH = "api/v1/auth";
const USERS = "api/v1/users";
const RANKINGS = "api/v1/rankings";
const GLOBAL_RANKINGS = "api/v1/global_rankings";

export function SHOW_RANKING(id: string) {
  return `${RANKINGS}/${id}`;
}

export function DOWNLOAD_LOG(id: string) {
  return `${LOGS}/${id}`;
}

export default {
  LOGS,
  AUTH,
  RANKINGS,
  USERS,
  SHOW_RANKING,
  DOWNLOAD_LOG,
  GLOBAL_RANKINGS,
};
