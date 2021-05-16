import { Route, Switch } from "react-router-dom";

import { SignIn, SignUp, NoMatch } from "../screens";

const AuthRoutes: React.FC = () => {
  return (
    <Switch>
      <Route path="/" component={SignIn} exact />
      <Route path="/signup" component={SignUp} />
      <Route path="*" component={NoMatch} />
    </Switch>
  );
};

export default AuthRoutes;
