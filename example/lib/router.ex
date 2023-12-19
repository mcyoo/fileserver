defmodule Example.Router do
  use Plug.Router
  use Plug.ErrorHandler

  alias Example.UserRouter
  alias Example.PostRouter

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Welcome")
  end

  forward("/users", to: UserRouter)
  forward("/posts", to: PostRouter)

  match _ do
    send_resp(conn, 404, "Oops!")
  end
end
