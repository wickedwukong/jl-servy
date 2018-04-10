defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> route
    |> format_response
  end

  def parse(request) do
    [request_line | header_lines] = request
                                     |> String.split("\n\n")
                                     |> List.first
                                     |> String.split("\n")

    [method, path | _] = String.split(request_line, " ")

    %{
      method: method,
      path: path,
      response_body: ""
    }
  end

  def route(conv) do
    # TODO: Create a new map that also has the response body:
    conv = %{ method: "GET", path: "/users", resp_body: "Asad, Tom, Sri" }
  end

  def format_response(conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Asad, Tom, Sri
    """
  end

end

request = """
GET /users HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response
