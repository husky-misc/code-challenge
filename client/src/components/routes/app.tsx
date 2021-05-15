import { Route, Switch } from "react-router-dom";

import {
  GameLog,
  Processing,
  Ranking,
  Signed,
  GlobalRanking,
  NoMatch,
} from "../screens";

const AppRoutes: React.FC = () => {
  return (
    <Switch>
      <Route path="/" component={GameLog} exact />
      <Route path="/processing" component={Processing} />
      <Route path="/ranking" component={Ranking} />
      <Route path="/global" component={GlobalRanking} />
      <Route path="/signed" component={Signed} />
      <Route path="*" component={NoMatch} />
    </Switch>
  );
};

export default AppRoutes;
