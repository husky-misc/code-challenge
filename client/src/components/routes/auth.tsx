import { Route, Switch } from "react-router-dom";

import { SignIn, SignUp, Signed } from "../screens";

const AuthRoutes: React.FC = () => {
  return (
    <Switch>
      <Route path="/" component={SignIn} exact />
      <Route path="/signup" component={SignUp} />
      <Route path="/signed" component={Signed} />
    </Switch>
  );
};

export default AuthRoutes;
