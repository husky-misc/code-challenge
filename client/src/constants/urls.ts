const LOGS = "api/v1/logs";
const GLOBAL_RANKINGS = "api/v1/global_rankings";
const RANKINGS = "api/v1/rankings";

export function SHOW_RANKING(id: string) {
  return `${RANKINGS}/${id}`;
}

export default { LOGS, GLOBAL_RANKINGS, RANKINGS, SHOW_RANKING };
