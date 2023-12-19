defmodule Example.PostRouter do
  use Plug.Router
  use Plug.ErrorHandler

  alias Example.PostRepo

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Post router")
  end

  get "/get/:id" do
    result = PostRepo.get_post(id)
    if result != nil do
      send_resp(conn, 200, result.title)
    else
      send_resp(conn, 404, "invaild post")
    end
  end

  post "/post" do
    IO.inspect(conn.body_params)
    case PostRepo.make_post(conn.body_params) do
      {:ok, _result} ->
        send_resp(conn, 200, "register")
      {:error, _changeset} ->
        send_resp(conn, 404, "error")
    end
  end

  delete "/delete/:id" do
    post = PostRepo.get_post(id)
    if post != nil do
      case PostRepo.delete_post(post) do
        {:ok, _result} ->
          send_resp(conn, 200, "delete complete")
        {:error, _changeset} ->
          send_resp(conn, 404, "error")
      end
    else
      send_resp(conn, 404, "invaild post")
    end
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
