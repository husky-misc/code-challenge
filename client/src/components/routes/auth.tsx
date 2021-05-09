import { Route, Switch } from "react-router-dom";

import { SignIn, SignUp, Signed } from "../screens";

const AuthRoutes: React.FC = () => {
  return (
    <Switch>
      <Route path="/" component={SignUp} exact />
      <Route path="/signin" component={SignIn} />
      <Route path="/signed" component={Signed} />
    </Switch>
  );
};

export default AuthRoutes;
