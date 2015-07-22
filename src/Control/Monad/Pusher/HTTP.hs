{-|
Module      : Control.Monad.Pusher.HTTP
Description : Typclass for IO monads that can issue HTTP requests
Copyright   : (c) Will Sewell, 2015
Licence     : MIT
Maintainer  : me@willsewell.com
Stability   : experimental

A typeclass for IO monads that can issue get and post requests. The intention is
to use the IO instance in the main library, and a mock in the tests.
-}
module Control.Monad.Pusher.HTTP (MonadHTTP(..)) where

import Control.Monad.Error (Error, ErrorT)
import Control.Monad.Reader (ReaderT)
import Network.HTTP.Client (Manager, Request, Response)
import qualified Data.ByteString.Lazy as BL

-- |These functions essentially abstract the corresponding functions from the
-- Wreq library.
class Monad m => MonadHTTP m where
  httpLbs :: Request -> Manager -> m (Response BL.ByteString)

instance MonadHTTP IO where
  httpLbs = httpLbs

instance MonadHTTP m => MonadHTTP (ReaderT r m) where
  httpLbs = httpLbs

instance (Error e, MonadHTTP m) => MonadHTTP (ErrorT e m) where
  httpLbs = httpLbs