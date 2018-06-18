import Servy.Parser, only: [parse: 1]

defmodule Servy.Handler do
  @users ["Asad", "Tom", "Sri"]
  def handle(request) do
    request
    |> parse
    |> IO.inspect
    |> route
    |> format_response
  end

  def route(conv) do
    route(conv, conv.method, conv.path)
  end

  def route(conv, "GET", "/users") do
    conv = %{ conv | response_body: "Asad, Tom, Sri" }
  end

  def route(conv, "GET", "/users" <> "/") do
    route(conv, "GET", "/users")
  end

  def route(conv, "GET", "/users/" <> id) do
    index = (id |> String.to_integer) - 1

    conv = %{ conv | response_body: Enum.at(@users, index) }
  end

  def route(conv, _, path) do
    conv = %{ conv | response_body: "Not found" }
  end


  def format_response(conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: #{String.length(conv.response_body)}\r
    \r
    #{conv.response_body}
    """
  end

end
