import { configureStore, combineReducers } from "@reduxjs/toolkit";
import logger from "redux-logger";
import { persistStore, persistReducer, FLUSH, REHYDRATE, PAUSE, PERSIST, PURGE, REGISTER } from "redux-persist";
// import { HYDRATE, createWrapper } from "next-redux-wrapper";
import storage from "redux-persist/lib/storage";
import myPageSlice from "./myPageSlice";
import nftFundSlice from "./nftFundSlice";
import musicSlice from "./musicSlice";
// slice 에서 export한 것 들!
import userSlice from "./userSlice";
import fundListSlice from "./nftFundFindSlice";
import marketSlice from "./nftMarketSlice";
// redux-persist 사용
const persistConfig = {
  key: "root",
  storage,
  whiteList: ["userSlice"],
};

const rootReducer = combineReducers({
  userInfo: userSlice.reducer,
  myPageInfo: myPageSlice.reducer,
  fundInfo: nftFundSlice.reducer,
  musicList: musicSlice.reducer,
  fundList: fundListSlice.reducer,
  marketInfo: marketSlice.reducer,
});

const persistedReducer = persistReducer(persistConfig, rootReducer);

export const store = configureStore({
  // reducer: rootReducer,
  reducer: persistedReducer,
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({
      // serializableCheck : false
      serializableCheck: { ignoredActions: [FLUSH, REHYDRATE, PAUSE, PERSIST, PURGE, REGISTER] },
    }).concat(logger),
});

export const persistor = persistStore(store);
