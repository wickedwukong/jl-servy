defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> IO.inspect
    |> route
    |> format_response
  end

  def parse(request) do
    [method, path | _] = request
                             |> String.split("\n")
                             |> List.first
                             |> String.split(" ")

    %{ method: method, path: path, response_body: "" }
  end

  def route(conv) do
    route(conv, conv.path)
  end


  def format_response(conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    #{conv.response_body}
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

anotherRequest = """
GET /users/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response
