import { Route, Switch } from "react-router-dom";

import { GameLog, Processing, Ranking, GlobalRanking } from "../screens";

const AppRoutes: React.FC = () => {
  return (
    <Switch>
      <Route path="/" component={GameLog} exact />
      <Route path="/processing" component={Processing} />
      <Route path="/ranking" component={Ranking} />
      <Route path="/global" component={GlobalRanking} />
    </Switch>
  );
};

export default AppRoutes;
