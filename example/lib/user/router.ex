defmodule Example.UserRouter do
  use Plug.Router
  use Plug.ErrorHandler

  alias Example.Plug.VerifyRequest
  alias Example.PersonRepo

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(VerifyRequest, fields: ["content", "mimetype"], paths: ["/users/upload"])
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Users router")
  end

  get "/get/:id" do
    result = PersonRepo.get_user(id)
    if result != nil do
      send_resp(conn, 200, result.name)
    else
      send_resp(conn, 404, "invaild user")
    end
  end

  post "/register" do
    IO.inspect(conn)
    case PersonRepo.sign_up(conn.body_params) do
      {:ok, _result} ->
        send_resp(conn, 200, "register")
      {:error, _changeset} ->
        send_resp(conn, 404, "error")
    end
  end

  get "/upload" do
    send_resp(conn, 201, "Uploaded")
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    IO.inspect(kind, label: :kind)
    IO.inspect(reason, label: :reason)
    IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, "Something went wrong")
  end
end
