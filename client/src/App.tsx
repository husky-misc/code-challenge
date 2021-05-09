import { BrowserRouter } from "react-router-dom";
import AppProvider from "./contexts";
import Routes from "./components/routes";

function App() {
  return (
    <BrowserRouter>
      <AppProvider>
        <Routes />
      </AppProvider>
    </BrowserRouter>
  );
}

export default App;
